
import 'package:flutter/material.dart';
import 'package:notch_dental/screens/dentist/DentistLogin.dart';
import 'package:notch_dental/screens/dentist/DentistSignup.dart';
import 'package:notch_dental/screens/customer/PatientLogin.dart';
import 'package:notch_dental/screens/customer/PatientSignup.dart';

class Signup extends StatefulWidget{
  const Signup({Key? key}) : super(key: key);
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  var isSelected = {};
  var selectedOption = 0;
  List<Widget> options = [const PatientSignup(), const DentistSignup()];
  List<bool> toggleButtonData = [true, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < toggleButtonData.length; i++) {
                      toggleButtonData[i] = i == index;
                      selectedOption=index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                //selectedBorderColor: Colors.red[700],
                //selectedColor: Colors.white,
                //fillColor: Colors.red[200],
                //color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: toggleButtonData,
                children: const [
                  Text("Patient"),
                  Text("Dentist")
                ],
              ),
              options[selectedOption]
            ],
          ),
        ),
      ),
    );
  }
}