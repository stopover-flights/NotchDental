
import 'dart:convert';

class Appointment {
  late var id;
  late DateTime time;
  late double listedPrice;
  late double fullPrice;
  late bool filled;
  late var serviceOfferedId;
  late var officeId;
  late var patientFilledId;

  Appointment ({
    required this.id,
    required this.time,
    required this.listedPrice,
    required this.fullPrice,
    required this.filled,
    this.serviceOfferedId,
    this.officeId,
    this.patientFilledId
  });

  void appointmentFromDatabase(var id, var time, var listedPrice, var fullPrice, var filled, var serviceOfferedId, var officeId, var patientFilledId){
      this.id = id;
      this.time = DateTime.parse(time);
      this.listedPrice = double.parse(listedPrice);
      this.fullPrice = double.parse(fullPrice);
      if(filled.toLowerCase()=="true"){
        this.filled = true;
      }else{
        this.filled = false;
      }
      this.serviceOfferedId = serviceOfferedId;
      this.officeId = officeId;
      this.patientFilledId = patientFilledId;
  }
}

