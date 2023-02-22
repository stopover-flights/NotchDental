
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_dental/models/appointment.dart';
import 'package:notch_dental/screens/widgets/AppointmentListViewItem.dart';

class Appointments extends StatefulWidget{
  const Appointments({Key? key}) : super(key: key);
  @override
  _Appointments createState() => _Appointments();
}

class _Appointments extends State<Appointments> {
  Appointment a = Appointment(id: "12", dateTime: DateTime(2023, 2, 22, 3,5), listedPrice: 21.1, percentDiscount: 30.0, fullPrice: 55.0, filled: false);
  var date = DateTime.now();
  String stringDate = DateFormat.yMMMMd().format(DateTime.now());
  List<Appointment> appointments =[];

  @override
  void initState() {
    appointments.add(a);
    appointments.add(a);
    //TODO: fetch appointments and insert into appointments list

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 30, 40, 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Appointment Slots",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 38,
                        width: 248,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          //shape: BoxShape.circle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //arrow_forward_ios_rounded
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    date = date.subtract(const Duration(days: 1));
                                    stringDate = DateFormat.yMMMMd().format(date);
                                  });
                                },
                                icon: const Icon(IconData(0xf571, fontFamily: 'MaterialIcons', matchTextDirection: true))
                            ),
                            Text(stringDate),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    date = date.add(const Duration(days: 1));
                                    stringDate = DateFormat.yMMMMd().format(date);
                                  });
                                },
                                icon: const Icon(IconData(0xf579, fontFamily: 'MaterialIcons', matchTextDirection: false))
                            )
                          ],
                        ),
                      ),
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

                          onPressed: (){
                            Navigator.pushReplacementNamed(context, "/dashboard/new");
                          },
                          child: const Text("Set Appointments",style: TextStyle(color: Colors.white),)
                      ),
                    ],
                  ),
                ),

                appointments.isEmpty?
                //Expanded(
                  //child:
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    //height: double.infinity,
                    child: const Text(
                      "No Appointments Yet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w400,
                          color: Color(0x77161C39)
                      ),
                    ),
                  )
                //)
                :
                //Expanded(
                 //   child:
                Padding(
                      padding: const EdgeInsets.only(top:40.0, bottom: 10.0),
                      child: Card(
                        elevation: 0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: appointments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AppointmentListViewItem(appointments[index]);
                          },
                        ),
                      ),
                    //),
                )
              ],
            ),
          )
    );
  }
}