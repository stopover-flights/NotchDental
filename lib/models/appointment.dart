
import 'dart:convert';

class Appointment {
  late var id;
  late DateTime dateTime;
  late double listedPrice;
  late double percentDiscount;
  late double fullPrice;
  late bool filled;
  late var serviceOfferedId;
  late var officeId;
  late var patientFilledId;

  Appointment ({
    required this.id,
    required this.dateTime,
    required this.listedPrice,
    required this.percentDiscount,
    required this.fullPrice,
    required this.filled,
    this.serviceOfferedId,
    this.officeId,
    this.patientFilledId
  });

  void appointmentFromDatabase(var id, var dateTime, var listedPrice, var percentDiscount, var fullPrice, var filled, var serviceOfferedId, var officeId, var patientFilledId){
      this.id = id;
      this.dateTime = DateTime.parse(dateTime);
      this.listedPrice = double.parse(listedPrice);
      this.fullPrice = double.parse(fullPrice);
      this.percentDiscount = double.parse(percentDiscount);
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

