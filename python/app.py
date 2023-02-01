import os
import psycopg2
from datetime import datetime
from dotenv import load_dotenv
from flask import Flask, request, Response

create_service_table = (
    "CREATE TABLE IF NOT EXISTS service (id SERIAL PRIMARY KEY, name TEXT);"
)

create_appointment_table = (
    """--begin-sql CREATE TABLE IF NOT EXISTS appointment 
    (id SERIAL PRIMARY KEY, time TIMESTAMP, listed_price NUMERIC(8,2), full_price NUMERIC(8,2), filled BOOLEAN, practice_id INTEGER, patient_id INTEGER);""" 
)

create_practice_table = (
    """CREATE TABLE IF NOT EXISTS dental_practice 
    (id SERIAL PRIMARY KEY, email TEXT, password TEXT, name TEXT, address1 TEXT, address2 TEXT, city TEXT, state TEXT, zip TEXT);"""
)

create_patient_table = (
    """CREATE TABLE IF NOT EXISTS patient
    (id SERIAL PRIMARY KEY, first_name TEXT, last_name TEXT, zip TEXT, email TEXT, password TEXT, phone_number TEXT);"""
)

insert_practice = ("""INSERT INTO dental_practice 
(email, password, name, address1, address2, city, state, zip)
VALUES (\'"""
                   )
                   
insert_appointment = (
    """INSERT INTO appointment (time, listed_price, full_price, discount_percentage, filled, office_id, patient_filled_id, service_id)
    VALUES (\'"""
)

insert_service = "INSERT INTO service (name) VALUES (\'"
load_dotenv()

insert_patient = "INSERT INTO patient (first_name, last_name, zip, email, password, phone_number) VALUES (\'"

url = os.getenv("DATABASE_URL")
connection = psycopg2.connect(url)

app = Flask(__name__)

@app.post("/register-patient")
def registerPatient():
    print("Entered Register Patient")
    data = request.get_json()
    first_name = data["first_name"]
    last_name = data["last_name"]
    zip = data["zip"]
    email = data["email"]
    password = data["password"]
    phone_number = data["phone_number"]
    filled_query = insert_patient + first_name + "\', \'" + last_name + "\', \'" + zip + "\', \'" + email + "\', \'" + password + "\', \'" + phone_number + "\') RETURNING id;"
    print("Filled query = " + filled_query)
    with connection:
        with connection.cursor() as cursor:
            print("About to create patient table")
            cursor.execute(create_patient_table)
            cursor.execute(filled_query)
            practice_id = cursor.fetchone()[0]
            resp = Response({"ID" : practice_id})
            print("Patient ID = ", practice_id)
        return resp

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
    filled_query = insert_practice + email + "\', \'" + password + "\', \'" + name + "\', \'" + address1 + "\', \'" + address2 + "\', \'" + city + "\', \'" + state + "\', \'" + zip + "\') RETURNING id;"
    print("Filled query = " + filled_query)
    with connection:
        with connection.cursor() as cursor:
            print("About to create practice table")
            cursor.execute(create_practice_table)
            cursor.execute(filled_query)
            practice_id = cursor.fetchone()[0]
            resp = Response({"ID" : practice_id})
            print("Practice ID = ", practice_id)
        return resp


@app.post("/create-service")
def createService():
    print("Entered Create Service")
    data = request.get_json()
    name = data["name"]
    print(name)
    print(id)
    with connection:
        with connection.cursor() as cursor:
            cursor.execute(create_service_table)
            filled_query = insert_service + name + "\') RETURNING id;"
            cursor.execute(filled_query)
            service_id = cursor.fetchone()[0]
            resp = Response({"ID" : service_id, "name" : name})
            print("Service ID = " , service_id)
    return resp


@app.get("/")
def home():
    return "Hello world!"