get_practice_info = "SELECT id, email, name, address1, address2, city, state, zip FROM dental_practice WHERE id = {practice_id};"

get_open_appointments = "SELECT * FROM appointment WHERE practice_id = {practice_id} AND is_active = true ORDER BY id ASC;"

get_appointments_by_date = "SELECT * FROM appointment WHERE practice_id = {practice_id} AND is_active = true AND time > '{date} 00:00:00' AND time < '{date} 23:59:00' ORDER BY id ASC"