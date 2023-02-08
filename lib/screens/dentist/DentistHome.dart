import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notch_dental/screens/dentist/AccountDetails.dart';
import 'package:notch_dental/screens/dentist/Appointments.dart';
import 'package:notch_dental/screens/dentist/NewAppointment.dart';
import 'package:notch_dental/screens/dentist/Notifications.dart';

class DentistHome extends StatefulWidget {
  const DentistHome({Key? key}) : super(key: key);
  @override
  _DentistHome createState() => _DentistHome();
}

class _DentistHome extends State<DentistHome> {

  final _navigatorKey = GlobalKey<NavigatorState>();

  int selectedMenuOption = 0;
  var menuItemWeights = [FontWeight.w400,FontWeight.w400,FontWeight.w400];

  @override
  initState() {
    super.initState();
    setFontWeights();
  }

  void setFontWeights(){
    for(var i = 0; i < menuItemWeights.length; i++){
      if(i==selectedMenuOption){
        menuItemWeights[i]=FontWeight.w700;
      }else{
        menuItemWeights[i]=FontWeight.w400;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          leadingWidth: 235.5,//195.5 + 40 - padding
          toolbarHeight: 129,
          leading: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: SizedBox(
              height: 75,
              child: SvgPicture.asset(
                "images/Notch_Dental_Logo.svg",
              ),
            ),
          ),
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(left: 56),
            child: Text(
              "Name of Dental Practice",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Color(0xFF161C39)
              ),
            ),
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          shape: const Border(
            bottom: BorderSide(
              color: Color(0xFF161C39),
              width: 1
            )
          )
        ),
        body: Row(
          children:[
            Container(
              decoration: const BoxDecoration(
                border:  Border(right:BorderSide( color: Color(0xFF161C39))),
              ),
              width: 259,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 40, top: 54),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            selectedMenuOption = 0;
                            setFontWeights();
                            _navigatorKey.currentState!.pushNamed("/dashboard");
                          });
                        },
                        child: Text(
                          "My Appointments",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: menuItemWeights[0],
                              color: const Color(0xFF161C39)
                          ),
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 39),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          selectedMenuOption = 1;
                          setFontWeights();
                          _navigatorKey.currentState!.pushNamed("/account");
                        });
                      },
                      child: Text(
                        "Account Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: menuItemWeights[1],
                          color: Color(0xFF161C39)
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 39),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          selectedMenuOption = 2;
                          setFontWeights();
                          _navigatorKey.currentState!.pushNamed("/notifications");
                        });
                      },
                      child: Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: menuItemWeights[2],
                          color: const Color(0xFF161C39)
                        ),
                      ),
                    )
                  ),

                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 2),
                child: Navigator(
                  reportsRouteUpdateToEngine: true,
                  initialRoute: '/dashboard',
                  key: _navigatorKey,
                  onUnknownRoute: (settings) {
                    return MaterialPageRoute<void>(
                      settings: settings,
                      builder: (BuildContext context) {
                        Navigator.pop(context);
                        return const Scaffold(body: Center(child: Text('Not Found'))); // This should never really be seen.
                      },
                    );
                  },
                  onGenerateRoute: (RouteSettings settings) {
                    WidgetBuilder builder;
                    switch (settings.name) {
                      case '/':
                      case '/dashboard':
                        builder = (BuildContext context) => Appointments();
                        break;
                      case '/account':
                        builder = (BuildContext context) =>  AccountDetails();
                        break;
                      case '/notifications':
                        builder = (BuildContext context) =>  Notifications();
                        break;
                      case '/dashboard/new':
                        builder = (BuildContext context) =>  NewAppointment();
                        break;
                      default:
                        throw Exception('Invalid route: ${settings.name}');
                    }
                    print("Navigation to ${settings}");
                    return CustomPageRoute(builder: builder, settings: settings);
                  },
                ),
              ),
            ),
          ]
        )
    );
  }
}
class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(seconds: 0);

  CustomPageRoute({builder, settings}) : super(builder: builder, settings: settings);
}