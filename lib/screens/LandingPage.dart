import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
        actions: [
          TextButton(onPressed: ()=>{Navigator.pushNamed(context,  "/login")},  child: const Text( "Login", style: TextStyle(color: Color(0xFFffffff)),),),
          TextButton(onPressed: ()=>{Navigator.pushNamed(context, "/signup")},  child: const Text("Sign up",style: TextStyle(color: Color(0xFFffffff)),),)
        ],
      ),
        body: Column(
            children:[]
        )
    );
  }
}