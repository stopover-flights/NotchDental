import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notch_dental/database.dart';

class DentistLogin extends StatelessWidget {
  const DentistLogin({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          leadingWidth: 350,//195.5 + 40 - padding
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Container(
              alignment: Alignment.center,
              height: 75,
              child: const Text(
                "Notch Dental",
                style: TextStyle(
                  fontSize: 47,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF161C39)
                ),
              )
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 50.0),
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color(0xFF161C39),
                    ),
                  ),
                  isScrollable: true,
                  tabs: [
                    Tab(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF161C39)
                            ),
                          ),
                        ),
                    Tab(
                          child: Text(
                            "About Notch",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF161C39)
                            ),
                          ),
                        )
                  ]
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
            children:[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left:50, top: 39),
                  child: Container(
                    width: 456,
                    height: 550,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      //shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(41),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Welcome to Notch Dental!",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF161C39)
                            ),
                          ),

                          const SizedBox(height: 20,),

                          const SizedBox(
                            width: 327,
                            child: Text(
                                "Sign in to upload your\nappointments, view your analytics,\nand edit your profile. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF161C39)
                                ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          TextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0x33161C39),
                                hintText: 'Username'
                            ),
                            controller: username,
                          ),

                          const SizedBox(height: 30),

                          TextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0x33161C39),
                                hintText: 'Password'
                            ),
                            obscureText: true,
                            controller: password,
                          ),

                          const SizedBox(height: 20),

                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: (){},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0x80161C39)
                                  ),
                                )
                            ),
                          ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: 150,
                            height: 48,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:MaterialStatePropertyAll<Color>(Color(0xFF161C39)),
                                ),

                                onPressed: (){
                                  //Navigator.pushReplacementNamed(context, "/dashboard/new");
                                },
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(
                                    fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white
                                  ),
                                )
                            ),
                          ),

                          const SizedBox(height: 18,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don\'t have an account?",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF161C39)
                                ),
                              ),
                              TextButton(
                                  onPressed: (){},
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF161C39)
                                    ),
                                  )
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ),
              ),
              const Center(child: Text("About Page"))
            ]
        )
        )


        /*Center(
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
        ),*/
      );
  }
}