import 'package:flutter/material.dart';
import 'package:notch_dental/database.dart';

class DentistLogin extends StatelessWidget {
  const DentistLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var username;
    var password;
    return Center(
      child: Column(
              children:[
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  onChanged: (text){username=text;},
                ),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (text){password=text;},
                ),
                ElevatedButton(
                    onPressed: ()=>{
                      if(dbFunctions().authenticateDentist(username, password)){
                        Navigator.pushNamed(context, "/dashboard")
                      }else{
                        Navigator.pushNamed(context, "/failed-authentication")
                      }
                    },
                    child: Text("Login")
                ),
                TextButton(onPressed: ()=>{Navigator.pushNamed(context, "/dentist-signup")}, child: Text("Sign up"))
              ]
          ),
    );
  }
}