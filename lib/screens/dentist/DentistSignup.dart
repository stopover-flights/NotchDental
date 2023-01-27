import 'package:flutter/material.dart';
import 'package:notch_dental/database.dart';

class DentistSignup extends StatelessWidget {
  const DentistSignup({super.key});
  @override
  Widget build(BuildContext context) {
    var email;
    var password;
    var repeatPassword;
    var name;
    var phone;
    var address1;
    var address2;
    var city;
    var state;
    var zip;

    return Column(
          children:[
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              onChanged: (text){email=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (text){password=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Repeat password',
              ),
              onChanged: (text){repeatPassword=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Office Name',
              ),
              onChanged: (text){name=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
              ),
              onChanged: (text){phone=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address Line 1',
              ),
              onChanged: (text){address1=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address Line 2',
              ),
              onChanged: (text){address2=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'City',
              ),
              onChanged: (text){city=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'State',
              ),
              onChanged: (text){state=text;},
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Zip',
              ),
              onChanged: (text){zip=text;},
            ),
            ElevatedButton(
                onPressed: (){
                  bool emailValid =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                  if(emailValid && password.length > 8 && password == repeatPassword && name.length>0 && phone.length>0 && address1.length>0 && city.length>0 && state.length>0 && zip.length>0){
                    if(dbFunctions.insertOfficeData(email, password, name, phone, address1, address2, city, state, zip ) == 200) {
                      Navigator.pushNamed(context, "/login");
                    }
                  }else{
                    print('enter correct information');
                  }
                },
                child: Text("Sign Up")
            ),
          ]
        );
  }
}