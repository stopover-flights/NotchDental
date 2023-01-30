import os
import psycopg2
from dotenv import load_dotenv
from flask import Flask, request, Response

CREATE_APPOINTMENTS_TABLE = (
    "CREATE TABLE IF NOT EXISTS service (id SERIAL PRIMARY KEY, name TEXT);"
)

INSERT_SERVICE_RETURN_ID = "INSERT INTO service (name) VALUES (%s) RETURNING id;"
load_dotenv()

url = os.getenv("DATABASE_URL")
connection = psycopg2.connect(url)

app = Flask(__name__)

@app.post("/create-service")
def createService():
    print("Entered Create Service")
    data = request.get_json()
    name = data["name"]
    print(name)
    print(id)
    with connection:
        with connection.cursor() as cursor:
            cursor.execute(CREATE_APPOINTMENTS_TABLE)
            cursor.execute(INSERT_SERVICE_RETURN_ID, (name,))
            service_id = cursor.fetchone()[0]
            resp = Response({"ID" : service_id, "name" : name})
            print("Service ID = " , service_id)
    return resp


@app.get("/")
def home():
    return "Hello world!"