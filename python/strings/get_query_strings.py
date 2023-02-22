get_practice_info = "SELECT id, email, name, address1, address2, city, state, zip FROM dental_practice WHERE id = {practice_id};"

get_open_appointments = "SELECT * FROM appointment WHERE practice_id = {practice_id} ORDER BY id ASC;"