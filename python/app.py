import os
import query_strings
import psycopg2
from datetime import datetime
from dotenv import load_dotenv
from flask import Flask, request, Response



load_dotenv()

url = os.getenv("DATABASE_URL")
connection = psycopg2.connect(url)

app = Flask(__name__)

def sendToServer(queries):
    with connection:
        with connection.cursor() as cursor:
            for query in queries:
                cursor.execute(query)
            id = cursor.fetchone()[0]
            resp = Response("ID = " + str(id))
        return resp
    
@app.post("/create-appointment")
def createAppointment():
    print("Entered create appointment")
    data = request.get_json()
    time = data["time"]
    filled_query = query_strings.insert_appointment + data["time"] + "\', \'" + str(data["listed_price"]) + "\', \'" + str(data["full_price"]) + "\', \'" + str(data["filled"]) + "\', \'" + str(data["practice_id"]) + "\', \'" + str(data["patient_id"]) + "\', \'" + str(data["service_id"])  + "\') RETURNING id;"
    print("filled appointment query = " + filled_query)
    return sendToServer([query_strings.create_appointment_table, filled_query])


@app.post("/register-patient")
def registerPatient():
    print("Entered Register Patient")
    data = request.get_json()
    filled_query = query_strings.insert_patient + data["first_name"] + "\', \'" + data["last_name"] + "\', \'" + data["zip"] + "\', \'" + data["email"] + "\', \'" + data["password"] + "\', \'" + data["phone_number"] + "\') RETURNING id;"
    print("Filled query = " + filled_query)
    return sendToServer([query_strings.create_patient_table, filled_query])
    

@app.post("/register-practice")
def registerPractice():
    print("Entered Register Practice")
    data = request.get_json()
    email = data["email"]
    password = data["password"]
    name = data["name"]
    address1 = data["address1"]
    address2 = data["address2"]
    city = data["city"]
    state = data["state"]
    zip = data["zip"]
    filled_query = query_strings.insert_practice + email + "\', \'" + password + "\', \'" + name + "\', \'" + address1 + "\', \'" + address2 + "\', \'" + city + "\', \'" + state + "\', \'" + zip + "\') RETURNING id;"
    print("Filled query = " + filled_query)
    return sendToServer([query_strings.create_practice_table, filled_query])

@app.post("/create-service")
def createService():
    print("Entered Create Service")
    data = request.get_json()
    name = data["name"]
    filled_query = query_strings.insert_service + name + "\') RETURNING id;"
    return sendToServer([query_strings.create_service_table, filled_query])


@app.get("/")
def home():
    return "Hello world!"

