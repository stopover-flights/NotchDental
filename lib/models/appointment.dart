
import 'dart:convert';

class Appointment {
  String? id;
  DateTime dateTime;
  double listedPrice;
  double percentDiscount;
  double fullPrice;
  bool? filled;
  String? serviceOfferedId;
  String? officeId;
  String? patientFilledId;

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

