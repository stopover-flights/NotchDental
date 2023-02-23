import json
import os
from strings import misc_query_strings
from strings import update_query_strings
from strings import create_query_strings
from strings import insert_query_strings
from strings import get_query_strings
import psycopg2
from dotenv import load_dotenv
from flask import Flask, request, Response
from passlib.hash import bcrypt

def create_app():

    load_dotenv()

    url = os.getenv("DATABASE_URL")
    connection = psycopg2.connect(url)
    app = Flask(__name__)

    hasher = bcrypt.using(rounds=13)

    def PostToDB(queries, hasReturn):
        with connection:
            with connection.cursor() as cursor:
                for query in queries:
                    cursor.execute(query)
                if(hasReturn):
                    id = cursor.fetchone()[0]
                    resp = Response("ID = " + str(id))
                else:
                    resp = Response("Success!")
            return resp
        
    def GetFromDB(queries, returnsMultiple = False):
        with connection:
            with connection.cursor() as cursor:
                for query in queries:
                    cursor.execute(query)
                    if returnsMultiple is True:
                        return_data = cursor.fetchall()
                    else:
                        return_data = cursor.fetchone()
                    resp = Response(return_data)
            return [resp, return_data]

    #GET REQUESTS
    
    @app.get("/")
    def home():
        return "Hello world!"

    @app.get("/login")
    def Login():
        data = request.get_json()
        verifyResult = CheckDBPass(data["email"], data["password"])
        resp = Response("Verification Result = " + json.dumps(verifyResult))
        return resp
    
    @app.get("/get-open-appointments")
    def getOpenAppointments():
        data = request.get_json()
        filled_query = get_query_strings.get_open_appointments.format(practice_id = data["practice_id"])
        return_data = GetFromDB({filled_query}, True)
        print("Appointments = " + str(type(return_data[1][1][1])))
        serialized_appts = SerializeAppointments(return_data[1])
        resp = Response()
        resp.set_data(json.dumps(serialized_appts))
        return resp
    
    @app.get("/get-practice-info")
    def getPracticeInfo():
        query = get_query_strings.get_practice_info.format(practice_id = request.get_json()["practice_id"])
        returnData = GetFromDB({query})
        returnInfo = {"id" : returnData[1][0], "email" : returnData[1][1], "name": returnData[1][2], "address1": returnData[1][3], "address2": returnData[1][4], "city": returnData[1][5], "state":returnData[1][6], "zip": returnData[1][7]}
        resp = Response(json.dumps(returnInfo, indent = 4))
        return resp
    
    #POST REQUESTS
    
    @app.post("/fill-appointment")
    def fillAppointment():
        print("Entered Fill Appointment")
        data = request.get_json()
        query = "UPDATE appointment SET patient_id = " + str(data["patient_id"]) + ", filled = true WHERE id = " + str(data["appointment_id"]) + ';'
        return PostToDB([query], False)
        
    @app.post("/create-appointment")
    def createAppointment():
        print("Entered create appointment")
        data = request.get_json()
        filled_query = insert_query_strings.insert_appointment + data["time"] + "\', \'" + str(data["listed_price"]) + "\', \'" + str(data["full_price"]) + "\', false, \'" + str(data["practice_id"]) + "\', NULL, \'" + str(data["service_id"])  + "\') RETURNING id;"
        print(filled_query)
        return PostToDB([create_query_strings.create_appointment_table, filled_query], True)

    @app.post("/register-patient")
    def registerPatient():
        print("Entered Register Patient")
        data = request.get_json()
        filled_query = insert_query_strings.insert_patient + data["first_name"] + "\', \'" + data["last_name"] + "\', \'" + data["zip"] + "\', \'" + data["email"] + "\', \'" + GenerateHash(data["password"]) + "\', \'" + data["phone_number"] + "\') RETURNING id;"
        print("Filled query = " + filled_query)
        return PostToDB([create_query_strings.create_patient_table, filled_query], True)
        
    @app.post("/register-practice")
    def registerPractice():
        print("Entered Register Practice")
        data = request.get_json()
        print("About to check for email")
        if EmailExists(data["email"]) == True:
            return Response("Email exists in Database- please use another")
        password = GenerateHash(data["password"])
        print("Hashed Password = " + password)
        filled_query = insert_query_strings.insert_practice + data["email"] + "\', \'" + password + "\', \'" + data["name"] + "\', \'" + data["address1"] + "\', \'" + data["address2"] + "\', \'" + data["city"] + "\', \'" + data["state"] + "\', \'" + data["zip"] + "\') RETURNING id;"
        print("Filled query = " + filled_query)
        return PostToDB([create_query_strings.create_practice_table, filled_query], True)

    @app.post("/reset-password")
    def ResetPassword():
        print("Entering Reset Password")
        data = request.get_json()
        new_pass_hashed = GenerateHash(data["new_password"])
        filled_query = update_query_strings.update_practice_password.format(password = new_pass_hashed, id = data["id"])
        print("Filled Query = " + filled_query)
        return PostToDB([filled_query], False)

    @app.post("/create-service")
    def createService():
        print("Entered Create Service")
        data = request.get_json()
        name = data["name"]
        filled_query = insert_query_strings.insert_service.format(name = data["name"])
        return PostToDB([create_query_strings.create_service_table, filled_query], True)
    
    #PUT REQUESTS

    @app.put("/update-practice")
    def updatePractice():
        print("Entered update practice")
        data = request.get_json()
        filled_query = update_query_strings.update_practice.format(name = data["name"],
                                                                           email = data["email"],
                                                                           address1 = data["address1"],
                                                                           address2 = data["address2"],
                                                                           city = data["city"],
                                                                           state = data["state"],
                                                                           zip = data["zip"],
                                                                           id = data["id"])
        print("Filled query = " + filled_query)
        return PostToDB({filled_query}, False)
        
    @app.put("/update-practice-password")
    def updatePracticePassword():
        print("Entering update practice password")
        data = request.get_json()
        #pass_result = CheckDBPass(data["email"], data["password"])
        #if(pass_result is False):
            #return Response("Incorrect password- please try again")
        #print("Pass result = " + str(pass_result))
        filled_query = update_query_strings.update_practice_password.format(hashed_pass = str(GenerateHash(data["new_password"])), id = data["id"])
        return PostToDB({filled_query}, False)
    
    @app.put("/update-appointment")
    def updateAppointment():
        print("Entered update appointment")
        data = request.get_json()
        filled_query = update_query_strings.update_appointment.format(time = data["time"],
                                                                      listed_price = data["listed_price"],
                                                                      full_price = data["full_price"],
                                                                      practice_id = data["practice_id"],
                                                                      service_id = data["service_id"],
                                                                      id = data["id"])
        print("Filled query = " + filled_query)
        return PostToDB({filled_query}, False)


    def EmailExists(input_email):
        check_query = misc_query_strings.check_if_email_exists.format(email = input_email)
        print("Query = " + check_query)
        email_exists_result = GetFromDB([check_query])
        emailExists = email_exists_result[1][0]
        return emailExists

    def GenerateHash(input_pass):
        return hasher.hash(input_pass)

    def CheckDBPass(input_email, input_pass):
        query = misc_query_strings.get_pass_hash_from_email.format(email = input_email)
        returnData = GetFromDB([query])
        returnInfo = {"password" : returnData[1][0]}
        return hasher.verify(input_pass, returnInfo.get("password"))
    
    def SerializeAppointments(appointments):
        serialized_appointments = []
        for appointment in appointments:
            new_appointment = list(appointment)
            new_appointment[1] = new_appointment[1].isoformat()
            new_appointment[2] = float(new_appointment[2])
            new_appointment[3] = float(new_appointment[3])
            serialized_appointments.append(new_appointment)
        print("Type of appointment in serialized_appointments = " + str(type(serialized_appointments[0])))
        #for object in serialized_appointments[0]:
            #print("Data type = " + str(type(object)) + " , Data = " + str(object))
        return serialized_appointments
                
    return app