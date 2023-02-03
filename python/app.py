import json
import os
import query_strings
import psycopg2
from dotenv import load_dotenv
from flask import Flask, request, Response

load_dotenv()

url = os.getenv("DATABASE_URL")
connection = psycopg2.connect(url)

app = Flask(__name__)

def sendPostRequest(queries, hasReturn):
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
    
def sendGetRequest(queries):
    print("Entering sendGetRequest")
    with connection:
        with connection.cursor() as cursor:
            for query in queries:
                cursor.execute(query)
                return_data = cursor.fetchone()
                print("Return Data Below:")
                print(return_data)
                resp = Response(return_data)
        return [resp, return_data]

@app.get("/get-practice-info")
def getPracticeInfo():
    query = "SELECT id, email, name, address1, address2, city, state, zip FROM dental_practice WHERE id = " + str(request.get_json()["practice_id"]) + ';'
    print("Query = " + query)
    returnData = sendGetRequest([query])
    print("Return data is of type:")
    print(type(returnData[1]))
    returnInfo = {"id" : returnData[1][0], "email" : returnData[1][1], "name": returnData[1][2], "address1": returnData[1][3], "address2": returnData[1][4], "city": returnData[1][5], "state":returnData[1][6], "zip": returnData[1][7]}
    print("Return info = " + str(returnInfo))
    return Response(json.dumps(returnInfo, indent = 4))
    
@app.post("/fill-appointment")
def fillAppointment():
    print("Entered Fill Appointment")
    data = request.get_json()
    query = "UPDATE appointment SET patient_id = " + str(data["patient_id"]) + ", filled = true WHERE id = " + str(data["appointment_id"]) + ';'
    return sendPostRequest([query], False)
    
@app.post("/create-appointment")
def createAppointment():
    print("Entered create appointment")
    data = request.get_json()
    filled_query = query_strings.insert_appointment + data["time"] + "\', \'" + str(data["listed_price"]) + "\', \'" + str(data["full_price"]) + "\', \'" + str(data["filled"]) + "\', \'" + str(data["practice_id"]) + "\', \'" + str(data["patient_id"]) + "\', \'" + str(data["service_id"])  + "\') RETURNING id;"
    print("filled appointment query = " + filled_query)
    return sendPostRequest([query_strings.create_appointment_table, filled_query], True)

@app.post("/register-patient")
def registerPatient():
    print("Entered Register Patient")
    data = request.get_json()
    filled_query = query_strings.insert_patient + data["first_name"] + "\', \'" + data["last_name"] + "\', \'" + data["zip"] + "\', \'" + data["email"] + "\', \'" + data["password"] + "\', \'" + data["phone_number"] + "\') RETURNING id;"
    print("Filled query = " + filled_query)
    return sendPostRequest([query_strings.create_patient_table, filled_query], True)
    
@app.post("/register-practice")
def registerPractice():
    print("Entered Register Practice")
    data = request.get_json()
    filled_query = query_strings.insert_practice + data["email"] + "\', \'" + data["password"] + "\', \'" + data["name"] + "\', \'" + data["address1"] + "\', \'" + data["address2"] + "\', \'" + data["city"] + "\', \'" + data["state"] + "\', \'" + data["zip"] + "\') RETURNING id;"
    print("Filled query = " + filled_query)
    return sendPostRequest([query_strings.create_practice_table, filled_query], True)

@app.post("/create-service")
def createService():
    print("Entered Create Service")
    data = request.get_json()
    name = data["name"]
    filled_query = query_strings.insert_service + name + "\') RETURNING id;"
    return sendPostRequest([query_strings.create_service_table, filled_query], True)

@app.get("/")
def home():
    return "Hello world!"

