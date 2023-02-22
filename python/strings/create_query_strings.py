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