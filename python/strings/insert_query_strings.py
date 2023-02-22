insert_practice = ("""INSERT INTO dental_practice 
(email, password, name, address1, address2, city, state, zip)
VALUES (\'""")
                   
insert_service = "INSERT INTO service (name) VALUES (\'{name}\') RETURNING id;"

insert_patient = "INSERT INTO patient (first_name, last_name, zip, email, password, phone_number) VALUES (\'"

insert_appointment = (
    """INSERT INTO appointment (time, listed_price, full_price, filled, practice_id, patient_id, service_id)
    VALUES (\'"""
)