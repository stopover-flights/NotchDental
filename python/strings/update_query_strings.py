update_practice_email = "UPDATE dental_practice SET email = \'{email}\' WHERE id = {id};"

update_practice_password = "UPDATE dental_practice SET password = \'{hashed_pass}\' WHERE id = {id};"

update_practice_name = "UPDATE dental_practice SET name = \'{name}\' WHERE id = {id};"

update_practice_address = """UPDATE dental_practice 
SET address1 = \'{address1}\',
address2 = \'{address2}\',
city = \'{city}\',
state = \'{state}\',
zip = \'{zip}\'
 WHERE id = {id};"""

update_appointment = """UPDATE appointment SET 
 time = \'{time}\',
 listed_price = {listed_price},
 full_price = {full_price},
 practice_id = {practice_id},
 service_id = {service_id}
WHERE id = {id};"""