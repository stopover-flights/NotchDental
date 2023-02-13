import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notch_dental/models/appointment.dart';

class NewAppointment extends StatefulWidget {
  NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointment();
}

class _NewAppointment extends State<NewAppointment> {
  var date = DateTime.now();
  var stringDate = DateFormat.yMMMMd().format(DateTime.now());
  var amPm = "AM";

  FocusNode minutesNode = FocusNode();
  FocusNode hoursNode = FocusNode();

  TextEditingController hours = TextEditingController();
  TextEditingController minutes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    var appointment;
    double totalAppointmentValue = 150.0;//todo:get from database
    var fifteenPercent = double.parse((totalAppointmentValue*0.85).toStringAsFixed(2));
    bool fifteen = false;
    var twentyPercent = double.parse((totalAppointmentValue*0.80).toStringAsFixed(2));
    bool twenty = false;
    var thirtyPercent = double.parse((totalAppointmentValue*0.70).toStringAsFixed(2));
    bool thirty = false;


    if(args!=null){
      appointment = args as Appointment;
    }
    TextEditingController _txtTimeController = TextEditingController();




    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        const Text(
          "Time",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xFF161C39)
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Container(
              height: 38,
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

            const SizedBox(width: 30),

            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)
              ),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center ,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:9),
                    child: SizedBox(
                      width: 30,
                      height: 27,
                      child: EditableText(
                        forceLine: true,
                        textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent:false,
                            applyHeightToLastDescent: false,
                        ),
                        controller: hours,
                        focusNode: hoursNode,
                        //cursorHeight: 20,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 15,
                            height: 2,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF161C39)
                        ),
                        onChanged: (text){
                          if(text.length>2){
                            hours.text = hours.text.substring(0, hours.text.length - 1);
                          }else if(text.length==2){
                            minutesNode.requestFocus();
                          }
                          setState(() {
                            hours.text=text;
                          });
                        },
                        cursorColor: const Color(0xFF161C39),
                        backgroundCursorColor: const Color(0xFFFFFFFF),
                      )
                    ),
                  ),
                  const Text(
                      ":",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF161C39)
                      ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:9),
                    child: SizedBox(
                      width: 30,
                      height: 27,
                      child: EditableText(
                        //forceLine: true,
                        textHeightBehavior: const TextHeightBehavior(
                          applyHeightToFirstAscent:false,
                          applyHeightToLastDescent: false,
                        ),
                        controller: minutes,
                        focusNode: minutesNode,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 2,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF161C39)
                        ),
                        onChanged: (text){
                          if(text.length>2){
                            minutes.text = minutes.text.substring(0, minutes.text.length - 1);
                          }else if(text.length==2){
                            minutesNode.unfocus();
                          }
                          setState(() {
                            minutes.text=text;
                          });
                        },
                        cursorColor: const Color(0xFF161C39),
                        backgroundCursorColor: const Color(0xFFFFFFFF),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 4),

            Container(
              width: 60,
              height: 38,
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                //shape: BoxShape.circle,
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: amPm,
                underline: const SizedBox(width: 0, height: 0,),
                items: const [
                  DropdownMenuItem(
                    value: "AM",
                    child: Text(
                      "  AM",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF161C39)
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "PM",
                    child: Text(
                      "  PM",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF161C39)
                      ),
                    ),
                  )
                ],
                onChanged: (Object? value) {
                  setState(() {
                    amPm = value.toString();
                  });
                },

              )
            ),
          ],
        ),

        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            "*We cannot publish appointment slots less than two hours before they are scheduled. ",
            softWrap: true,
            maxLines: 3,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF161C39)
            ),
          ),
        ),

        const SizedBox(height: 30,),

        const Text(
            "Pricing",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Color(0xFF161C39)
            ),
        ),

        const SizedBox(height: 10),

        const Text(
            "Choose a discount amount",
            softWrap: true,
            maxLines: 3,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF161C39)
            ),
          ),

        const SizedBox(height: 10),

        Row(
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: fifteen ? MaterialStateProperty.all(Color(0xFF161C39)) : MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Color(0xFF161C39), width: 2)
                        )
                    )
                ),
                onPressed: (){
                  setState(() {
                    fifteen = true;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "15% (\$$fifteenPercent)",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: fifteen ? Color(0xFFFFFFFF) : Color(0xFF161C39)
                    ),
                  ),
                )
            ),

            const SizedBox(width: 20),

            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Color(0xFF161C39), width: 2)
                        )
                    )
                ),
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "20% (\$$twentyPercent)",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF161C39)
                    ),
                  ),
                )
            ),

            const SizedBox(width: 20),

            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Color(0xFF161C39), width: 2)
                      )
                  )
                ),
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "30% (\$$thirtyPercent)",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF161C39)
                    ),
                  ),
                ),
            )
          ],
        ),

        const SizedBox(height: 20),

        const Text(
          "*These are calculated using the pricing amount you have indicated in your account information.",
          softWrap: true,
          maxLines: 3,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF161C39)
          ),
        ),

        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
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

              onPressed: (){
                Navigator.pushReplacementNamed(context, "/dashboard/new");
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Set Appointment",style: TextStyle(color: Colors.white, fontSize: 20)),
              )
          ),
        )
      ],
    );
  }
}

//create a textfield the inputs the time in hours and minutes an am/pm

