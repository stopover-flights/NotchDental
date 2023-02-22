import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_dental/models/appointment.dart';

class NewAppointment extends StatefulWidget {
  NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointment();
}

class _NewAppointment extends State<NewAppointment> {
  //TODO: get practice data
  late Appointment appointment;

  var stringDate = DateFormat.yMMMMd().format(DateTime.now());
  var amPm = "AM";
  bool firstBuild = true;

  double totalAppointmentValue = 150.0;//todo:get from database
  double standardDiscount = 30;
  double dollarPrice = 0;

  FocusNode minutesNode = FocusNode();
  FocusNode hoursNode = FocusNode();

  TextEditingController hours = TextEditingController();
  TextEditingController minutes = TextEditingController();

  TextEditingController percentDiscount = TextEditingController();
  TextEditingController dollarDiscount = TextEditingController();


  bool adjustDiscount = false;
  bool editingPercentage = false;
  bool editingDollars = false;

  bool correctTimeFormat = true;
  bool correctPercentFormat = true;
  bool correctPriceFormat = true;

  correctOutput(){
    try{
      var d = appointment.dateTime.day;
      var m = appointment.dateTime.month;
      var y = appointment.dateTime.year;
      var h = amPm=="AM" ? int.parse(hours.text) : (int.parse(hours.text) + 12);
      var min = int.parse(minutes.text);
      var pc = percentDiscount.text;
      var dp = dollarDiscount.text;
      var finalDate;
      print("$h, $min");
      bool error = false;
      if(h < 0|| h > 24 || min < 0 || min > 59){
        setState(() {
          correctTimeFormat = false;
        });
        error = true;
      }
      if(double.parse(pc) < 0 || double.parse(pc) > 100){
        correctPercentFormat = false;
        error = true;
      }

      if(double.parse(dp) < 0){
        correctPriceFormat = false;
        error = true;
      }

      if(error){
        return false;
      }
      finalDate = DateTime(y,m,d,h,min);
      print("Discount: $pc; Final price: $dp");
      print(finalDate);
      return true;
    } on Exception catch (e){
      setState(() {
        correctTimeFormat = false;
      });
      return false;
    }

  }


  @override
  void initState() {
    hoursNode.addListener((){
      if(hoursNode.hasFocus){
        if(hours.text=="00" || hours.text=="0"){
          hours.text="";
        }
      }else{
        if(hours.text=="" || hours.text=="0"){
          hours.text="00";
        }
      }
    });
    minutesNode.addListener(() {
      if(minutesNode.hasFocus){
        if(minutes.text=="00" || minutes.text=="0"){
          minutes.text="";
        }
      }else{
        if(minutes.text=="" || minutes.text=="0"){
          minutes.text="00";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if(firstBuild) {
      //date = DateTime(date.year, date.month, date.day);
      print("This should only run once");
      if (args != null) {
        appointment = args as Appointment;

        hours.text = appointment.dateTime.hour.toStringAsFixed(0);
        if(appointment.dateTime.minute<10){
          minutes.text = "0${appointment.dateTime.minute}";
        }else {
          minutes.text = appointment.dateTime.minute.toStringAsFixed(0);
        }

        if(appointment.dateTime.hour == 0){
          hours.text = "00";
        }else {
          if (appointment.dateTime.hour > 12) {
            hours.text = (appointment.dateTime.hour - 12).toString();
            amPm = "PM";
          } else {
            hours.text = appointment.dateTime.hour.toString();
          }
        }

        if(appointment.dateTime.minute==0){
          minutes.text = "00";
        }

      } else {
        dollarPrice = totalAppointmentValue-(standardDiscount * totalAppointmentValue / 100);
        appointment = Appointment(
          id: "123",
          dateTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
          listedPrice: dollarPrice,
          percentDiscount: standardDiscount,
          fullPrice: totalAppointmentValue,
          filled: false
        );
        hours.text = "00";
        minutes.text = "00";

      }
      firstBuild=false;
      //initState();
    }
    if(editingPercentage){
      editingPercentage = false;
      appointment.listedPrice = (appointment.fullPrice*(100-appointment.percentDiscount)/100);
    }else if(editingDollars){
      editingDollars = false;
      appointment.percentDiscount = (100-(appointment.listedPrice/appointment.fullPrice*100));
    }

    totalAppointmentValue = appointment.fullPrice;
    standardDiscount = appointment.percentDiscount;
    dollarPrice = appointment.listedPrice;
    dollarDiscount.text = appointment.listedPrice.toStringAsFixed(2);
    percentDiscount.text = appointment.percentDiscount.toStringAsFixed(0);
    /*if(appointment.dateTime.minute == 0){
      //minutes.text = "";
    }else{
      //minutes.text = appointment.dateTime.minute.toString();
    }
    if(appointment.dateTime.hour == 0){
      //hours.text = "";
    }else {
      if (appointment.dateTime.hour > 12) {
        //hours.text = (appointment.dateTime.hour - 12).toString();
        amPm = "PM";
      } else {
        //hours.text = appointment.dateTime.hour.toString();
      }
    }*/


    hours.selection = TextSelection.fromPosition(TextPosition(offset: hours.text.length));
    minutes.selection = TextSelection.fromPosition(TextPosition(offset: minutes.text.length));
    percentDiscount.selection = TextSelection.fromPosition(TextPosition(offset: percentDiscount.text.length));
    dollarDiscount.selection = TextSelection.fromPosition(TextPosition(offset: dollarDiscount.text.length));

    return SingleChildScrollView(
      child:
      Padding(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 38,
              width: 248,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        appointment.dateTime = appointment.dateTime.subtract(const Duration(days: 1));
                        stringDate = DateFormat.yMMMMd().format(appointment.dateTime);
                      });
                    },
                    icon: const Icon(IconData(0xf571, fontFamily: 'MaterialIcons', matchTextDirection: true))
                  ),
                  Text(stringDate),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        appointment.dateTime = appointment.dateTime.add(const Duration(days: 1));
                        stringDate = DateFormat.yMMMMd().format(appointment.dateTime);
                      });
                    },
                    icon: const Icon(IconData(0xf579, fontFamily: 'MaterialIcons', matchTextDirection: false))
                  )
                ],
              ),
            ),

            const SizedBox(height: 26),

            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
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

                    //Time Entry
                    Row(
                      children: [

                        Container(
                          height: 27,
                          decoration: BoxDecoration(
                            border: Border.all(color: correctTimeFormat ? Colors.black : Colors.red , width: 1)
                          ),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:0, bottom: 0),
                                child: SizedBox(
                                  width: 30,
                                  height: 17,
                                  child: TextField(
                                    controller: hours,
                                    textAlign: TextAlign.right,
                                    cursorColor: const Color(0xFF161C39),
                                    decoration: const InputDecoration.collapsed(hintText: ""),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      //height: 2,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF161C39)
                                    ),
                                    focusNode: hoursNode,
                                    onChanged: (text){
                                      hours.text = text;
                                      if(text.length>2){
                                        //appointment.dateTime = DateTime(date.year, date.month,date.day,hours.text.substring(0, hours.text.length - 1))
                                        hours.text = hours.text.substring(0, hours.text.length - 1);
                                      }else if(text.length==2){
                                        minutesNode.requestFocus();
                                      }
                                      setState(() {
                                        hours.text=text;
                                        //date=DateTime(date.year, date.month,date.day,int.parse(hours.text), date.minute);
                                        //appointment.dateTime = DateTime(appointment.dateTime.year, appointment.dateTime.month,appointment.dateTime.day,int.parse(hours.text), appointment.dateTime.minute);
                                      });
                                      //hours.selection = TextSelection.fromPosition(TextPosition(offset: hours.text.length));
                                    },
                                  )
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.only(bottom:4.0),
                                child: Text(
                                  ":",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF161C39)
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top:9),
                                child: SizedBox(
                                  width: 30,
                                  height: 17,
                                  child: TextField(
                                    controller: minutes,
                                    textAlign: TextAlign.left,
                                    cursorColor: const Color(0xFF161C39),
                                    focusNode: minutesNode,
                                    decoration: const InputDecoration.collapsed(hintText: ""),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      //height: 2,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF161C39)
                                    ),
                                    onChanged: (text){
                                      minutes.text = text;
                                      if(text.length>2){
                                        minutes.text = minutes.text.substring(0, minutes.text.length - 1);
                                      }else if(text.length==2){
                                        minutesNode.unfocus();
                                      }
                                      setState(() {
                                        minutes.text=text;
                                      });
                                      //appointment.dateTime = DateTime(appointment.dateTime.year, appointment.dateTime.month,appointment.dateTime.day, appointment.dateTime.hour, int.parse(minutes.text));
                                      //minutes.selection = TextSelection.fromPosition(TextPosition(offset: minutes.text.length));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),

                        Container(
                            width: 60,
                            height: 27,
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

                    correctTimeFormat
                        ?
                    SizedBox()
                        :
                    const Text(
                      "Please enter a valid time",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.red,
                          fontWeight: FontWeight.w300
                      ),
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

                    //Percent discount
                    Row(
                      children: [
                        const Text(
                          "Discount: ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF161C39)
                          ),
                        ),
                        adjustDiscount
                            ?
                        Row(
                          children: [
                            Container(
                              width: 39,
                              height: 27,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                      cursorColor: const Color(0xFF161C39),
                                      decoration: const InputDecoration.collapsed(hintText: ""),
                                      controller: percentDiscount,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF161C39)
                                      ),
                                      onChanged: (text){
                                        setState(() {
                                          editingPercentage = true;
                                          appointment.percentDiscount = double.parse(text);
                                        });
                                      },
                                  ),
                              ),
                            ),
                            const Text(
                                "% Off Standard Price",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF161C39)
                                )
                            ),
                          ],
                        )
                            :
                        Text(
                          "${appointment.percentDiscount}% Off Standard Price",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF161C39)
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 10),

                    //Final Price
                    Row(
                      children: [
                        const Text(
                          "Final Price: \$",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF161C39)
                          ),
                        ),
                        adjustDiscount
                        ?
                        Container(
                          height: 27,
                          width: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:TextField(
                                  cursorColor: const Color(0xFF161C39),
                                  decoration: const InputDecoration.collapsed(hintText: ""),
                                  controller: dollarDiscount,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF161C39)
                                  ),
                                onChanged: (text){
                                    setState(() {
                                      editingDollars = true;
                                      appointment.listedPrice=double.parse(text);
                                    });
                                },
                              ),
                          ),
                        )
                            :
                        Text(
                          appointment.listedPrice.toString(),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF161C39)
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    !adjustDiscount
                    ?
                    TextButton(
                      onPressed: () {
                        setState(() {
                          adjustDiscount = true;
                        });
                      },
                      child: const Text(
                        "edit default",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF161C39)
                        ),
                      ),
                    )
                    :
                    const SizedBox(),

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
                            if(correctOutput()){
                              Navigator.pushReplacementNamed(context, "/dashboard");
                            }

                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Save",style: TextStyle(color: Colors.white, fontSize: 20)),
                          )
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
