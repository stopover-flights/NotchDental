create_service_table = (
    "CREATE TABLE IF NOT EXISTS service (id SERIAL PRIMARY KEY, name TEXT);"
)

create_appointment_table = (
    """CREATE TABLE IF NOT EXISTS appointment 
    (id SERIAL PRIMARY KEY, time TIMESTAMPTZ, listed_price NUMERIC(8,2), full_price NUMERIC(8,2), filled BOOLEAN, practice_id INTEGER, patient_id INTEGER, service_id INTEGER);""" 
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
VALUES (\'""")
                   
insert_service = "INSERT INTO service (name) VALUES (\'"

insert_patient = "INSERT INTO patient (first_name, last_name, zip, email, password, phone_number) VALUES (\'"

insert_appointment = (
    """INSERT INTO appointment (time, listed_price, full_price, filled, practice_id, patient_id, service_id)
    VALUES (\'"""
)

get_pass_hash_from_email = "SELECT password FROM dental_practice WHERE email = \'"

check_if_email_exists = "SELECT exists (SELECT 1 FROM dental_practice WHERE email = \'{email}\' LIMIT 1)"