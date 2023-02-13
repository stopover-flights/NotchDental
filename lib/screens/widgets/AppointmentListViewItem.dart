import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_dental/models/appointment.dart';

class AppointmentListViewItem extends StatelessWidget {
  late Appointment appointment;

  AppointmentListViewItem(this.appointment, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.jm().format(appointment.time), style: const TextStyle(color: Color(0xFF161C39), fontWeight: FontWeight.w700, fontSize: 20),),
                Text("\$${appointment.listedPrice}", style: const TextStyle(color: Color(0xFF161C39), fontWeight: FontWeight.w700, fontSize: 20)),
                Text(
                    "Regaining ${(appointment.listedPrice/appointment.fullPrice*100).toInt()}% Revenue",
                    style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF161C39)
                )),
                ElevatedButton(
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
                    child: const Text("EDIT",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),)
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFF000000), width: 1.5),
              borderRadius: BorderRadius.circular(25.0)
          ),
        )
    );

  }
}