class Appointment:
    def __init__(self, id, time, listed_price, full_price, filled, practice_id, patient_id, service_id, is_active):
        self.id = id
        self.time = time
        self.listed_price = listed_price
        self.full_price = full_price
        self.filled = filled
        self.practice_id = practice_id
        self.patient_id = patient_id
        self.service_id = service_id
        self.is_active = is_active