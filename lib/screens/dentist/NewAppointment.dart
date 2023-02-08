import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notch_dental/models/appointment.dart';

class NewAppointment extends StatefulWidget {
  NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointment();
}

class _NewAppointment extends State<NewAppointment> {

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    var appointment;
    if(args!=null){
      appointment = args as Appointment;
    }
    TextEditingController _txtTimeController = TextEditingController();



    FocusNode minutesNode = FocusNode();
    FocusNode hoursNode = FocusNode();

    TextEditingController hours = TextEditingController();
    TextEditingController minutes = TextEditingController();


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

/*
        TextField(
          controller: _txtTimeController,
          decoration: InputDecoration(
            labelText: 'Time',
            hintText: 'HH:MM',
          ),
          keyboardType: TextInputType.datetime,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
          ],
          onChanged: (value) {
            if (value.length == 2) {
              _txtTimeController.text = value + ':';
              _txtTimeController.selection = TextSelection.fromPosition(
                TextPosition(offset: _txtTimeController.text.length),
              );
            }
          },
        ),
*/
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
                padding: const EdgeInsets.only(top:3),
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
                    },
                    cursorColor: const Color(0xFF161C39),
                    backgroundCursorColor: const Color(0xFFFFFFFF),
                  )/*TextField(
                    //textAlignVertical: TextAlignVertical.top,
                    cursorColor: const Color(0xFF161C39),
                    cursorHeight: 15,
                    textAlign: TextAlign.center,
                    controller: hours,
                    //maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      fillColor: Colors.green,filled: true,
                      //border: InputBorder.none,
                      //contentPadding: EdgeInsets.only(top: 5),
                      //counterText: "",
                    ),
                    onChanged: (text){
                      if(text.length>=2){
                        myFocusNode.requestFocus();
                      }
                    },
                    style: const TextStyle(
                        fontSize: 15,
                        height: 2,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF161C39)
                    ),
                  )*/,
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
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  width: 30,
                  height: 27,
                  child: EditableText(
                    forceLine: true,
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
                    },
                    cursorColor: const Color(0xFF161C39),
                    backgroundCursorColor: const Color(0xFFFFFFFF),
                  ),
                  /*TextField(
                    cursorColor: const Color(0xFF161C39),
                    cursorHeight: 15,
                    maxLines: 1,
                    focusNode: minutesNode,
                    textAlign: TextAlign.left,
                    controller: minutes,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        //height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF161C39)
                    ),
                  ),*/
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

//create a textfield the inputs the time in hours and minutes an am/pm

