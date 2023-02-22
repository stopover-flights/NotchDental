get_pass_hash_from_email = "SELECT password FROM dental_practice WHERE email = \'{email}\';"

check_if_email_exists = "SELECT exists (SELECT 1 FROM dental_practice WHERE email = \'{email}\' LIMIT 1)"