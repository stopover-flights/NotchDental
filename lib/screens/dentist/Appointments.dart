
import 'package:flutter/material.dart';
import 'package:notch_dental/models/appointment.dart';
import 'package:notch_dental/screens/dentist/DentistLogin.dart';
import 'package:notch_dental/screens/customer/PatientLogin.dart';

class Appointments extends StatefulWidget{
  const Appointments({Key? key}) : super(key: key);
  @override
  _Appointments createState() => _Appointments();
}

class _Appointments extends State<Appointments> {
  List<Appointment> appointments =[];
  List<Widget> views = [

  ];

  @override
  void initState() {
    //TODO: fetch appointments and insert into appointmnets list
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "No Appointments \nSet Today!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF161C39)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:const MaterialStatePropertyAll<Color>(Color(0xFF161C39)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                //side: const BorderSide(color: Colors.red)
                              )
                          )
                      ),

                      onPressed: ()=>{

                      },
                      child: const Text("Save Updates",style: TextStyle(color: Colors.white),)
                  ),
                ),
            ),
          ],
        ),
      );
  }
}