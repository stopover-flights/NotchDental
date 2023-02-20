import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_dental/models/appointment.dart';

class NewAppointment extends StatefulWidget {
  NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointment();
}

class _NewAppointment extends State<NewAppointment> {
  var appointment;

  var date = DateTime.now();
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

  correctOutput(){
    var d = date.day;
    var m = date.month;
    var y =date.year;
    var h = amPm=="AM" ? int.parse(hours.text) : (int.parse(hours.text) + 12);
    if(h>=24){
      h=0;
    }
    var min = int.parse(minutes.text);
    var pc = percentDiscount.text;
    var dp = dollarDiscount.text;
    print("$y-$m-$d $h:$min");
    print("Discount: $pc; Final price: $dp");
  }
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;

    if(args!=null){
      appointment = args as Appointment;
      totalAppointmentValue = appointment.fullPrice;
      standardDiscount = appointment.percentDiscount;
      dollarPrice = appointment.listedPrice;
      firstBuild=false;
      DateTime datetime = appointment.dateTime;
      dollarDiscount.text = appointment.listedPrice.toString();
      percentDiscount.text = appointment.percentDiscount.toString();
      minutes.text = datetime.minute.toString();
      if(datetime.hour>12){
        hours.text = (datetime.hour-12).toString();
        amPm="PM";
      }else{
        hours.text = datetime.hour.toString();
      }

    }

    /*
    if(firstBuild){
      dollarDiscount.text = (totalAppointmentValue*(100-standardDiscount)/100).toStringAsFixed(2);
      percentDiscount.text = standardDiscount.toStringAsFixed(0);
      firstBuild=false;
    }else if(editingPercentage){
      editingPercentage = false;
      dollarDiscount.text = (totalAppointmentValue*(100-standardDiscount)/100).toStringAsFixed(2);
    }else if(editingDollars){
      editingDollars = false;
      percentDiscount.text = (100-(dollarPrice/totalAppointmentValue*100)).toStringAsFixed(0);
    }
    */

    return Column(
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

                Row(
                  children: [

                    Container(
                      height: 27,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)
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
                                  onChanged: (text){
                                    if(text.length>2){
                                      hours.text = hours.text.substring(0, hours.text.length - 1);
                                    }else if(text.length==2){
                                      minutesNode.requestFocus();
                                    }
                                    setState(() {
                                      hours.text=text;
                                    });
                                    hours.selection = TextSelection.fromPosition(TextPosition(offset: hours.text.length));
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
                                  if(text.length>2){
                                    minutes.text = minutes.text.substring(0, minutes.text.length - 1);
                                  }else if(text.length==2){
                                    minutesNode.unfocus();
                                  }
                                  setState(() {
                                    minutes.text=text;
                                  });
                                  minutes.selection = TextSelection.fromPosition(TextPosition(offset: minutes.text.length));
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
                                      standardDiscount = double.parse(text);
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
                      "$standardDiscount% Off Standard Price",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF161C39)
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 10),

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
                                  dollarPrice=double.parse(text);
                                });
                            },
                          ),
                      ),
                    )
                        :
                    Text(
                      dollarDiscount.text,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF161C39)
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 20),

                !adjustDiscount ?
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
                        correctOutput();
                        if(true/*database entry succcessful*/){
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
    );
  }
}
