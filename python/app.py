import json
import os
import query_strings
import psycopg2
from dotenv import load_dotenv
from flask import Flask, request, Response
from passlib.hash import bcrypt

load_dotenv()

url = os.getenv("DATABASE_URL")
connection = psycopg2.connect(url)

app = Flask(__name__)

hasher = bcrypt.using(rounds=13)

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
    with connection:
        with connection.cursor() as cursor:
            for query in queries:
                cursor.execute(query)
                return_data = cursor.fetchone()
                resp = Response(return_data)
        return [resp, return_data]

@app.get("/get-practice-info")
def getPracticeInfo():
    query = query_strings.get_practice_info.format(id = request.get_json()["practice_id"])
    returnData = sendGetRequest([query])
    returnInfo = {"id" : returnData[1][0], "email" : returnData[1][1], "name": returnData[1][2], "address1": returnData[1][3], "address2": returnData[1][4], "city": returnData[1][5], "state":returnData[1][6], "zip": returnData[1][7]}
    resp = Response(json.dumps(returnInfo, indent = 4))
    return resp
    
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
    print("About to check for email")
    if EmailExists(data["email"]) == True:
        return Response("Email exists in Database- please use another")
    password = GenerateHash(data["password"])
    print("Hashed Password = " + password)
    filled_query = query_strings.insert_practice + data["email"] + "\', \'" + password + "\', \'" + data["name"] + "\', \'" + data["address1"] + "\', \'" + data["address2"] + "\', \'" + data["city"] + "\', \'" + data["state"] + "\', \'" + data["zip"] + "\') RETURNING id;"
    print("Filled query = " + filled_query)
    return sendPostRequest([query_strings.create_practice_table, filled_query], True)

@app.post("/reset-password")
def ResetPassword():
    print("Entering Reset Password")
    data = request.get_json()
    new_pass_hashed = GenerateHash(data["new_password"])
    filled_query = query_strings.update_password.format(password = new_pass_hashed, id = data["id"])
    print("Filled Query = " + filled_query)
    return sendPostRequest([filled_query], False)

@app.post("/create-service")
def createService():
    print("Entered Create Service")
    data = request.get_json()
    name = data["name"]
    filled_query = query_strings.insert_service.format(name = data["name"])
    return sendPostRequest([query_strings.create_service_table, filled_query], True)

@app.get("/")
def home():
    return "Hello world!"

@app.get("/login")
def Login():
    data = request.get_json()
    query = query_strings.get_pass_hash_from_email.format(email = data["email"])
    returnData = sendGetRequest([query])
    returnInfo = {"password" : returnData[1][0]}
    verifyResult = VerifyHash(data["password"], returnInfo.get("password"))
    resp = Response("Verification Result = " + json.dumps(verifyResult))
    return resp

def EmailExists(input_email):
    check_query = query_strings.check_if_email_exists.format(email = input_email)
    print("Query = " + check_query)
    email_exists_result = sendGetRequest([check_query])
    emailExists = email_exists_result[1][0]
    return emailExists

def GenerateHash(input_pass):
    return hasher.hash(input_pass)
    
def VerifyHash(input_pass, db_pass):
    return hasher.verify(input_pass, db_pass)
