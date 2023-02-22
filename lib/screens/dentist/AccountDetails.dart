import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:notch_dental/models/office.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);
  @override
  _AccountDetails createState() => _AccountDetails();
}
class _AccountDetails extends State<AccountDetails> {

  static Office office = Office(
    name: "Rock Canyon Dental",
    address1: "123 Place Rd.",
    address2:"",
    city:"Provo",
    state: "UT",
    zip: "84604",
    username: "dentist@dental.com",
    password: "*********",
    cleaningPrice: "120",
    email: "dentist@dental.com",
    phone: "8011234567",
    contactMethod: "Just email",
    bankRouting: "123456789",
    bankAccount: "*******1234",
  );
  String contactType = office.contactMethod;
  TextEditingController name = TextEditingController(text: office.name);
  TextEditingController address = TextEditingController(text: office.address1);
  TextEditingController address2 = TextEditingController(text: office.address2);
  TextEditingController city = TextEditingController(text: office.city);
  TextEditingController state = TextEditingController(text: office.state);
  TextEditingController zip = TextEditingController(text: office.zip);
  TextEditingController username = TextEditingController(text: office.username);
  TextEditingController password = TextEditingController(text: office.password);
  TextEditingController email = TextEditingController(text: office.email);
  TextEditingController phone = TextEditingController(text: office.phone);
  TextEditingController price = TextEditingController(text: office.cleaningPrice);
  TextEditingController bankRouting = TextEditingController(text: office.bankRouting);
  TextEditingController bankAccount = TextEditingController(text: office.bankAccount);
  TextEditingController newPassword = TextEditingController();
  TextEditingController repeatNewPassword = TextEditingController();



  var editPracticeInfo = false;
  var editPassword = false;
  var editAccountInfo =  false;
  var editContactInfo = false;
  var editBankInfo =  false;
  //TODO:
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 2),
        child: LayoutGrid(
          columnSizes: [1.fr, 1.fr],
          rowSizes: const [auto, auto, auto, auto],
          rowGap: 40,
          columnGap: 15,
          children: [
            //ACCOUNT INFO
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account Information",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF161C39)
                      ),
                    ),
                    IconButton(
                      onPressed: ()=>{
                        setState((){
                          editAccountInfo=true;
                        })
                      },
                      icon: const Icon(IconData(0xef8d, fontFamily: 'MaterialIcons'), color: Color(0xFF161C39),))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Name of Practice",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                editAccountInfo ?
                SizedBox(
                  width: 250,
                  child: TextField(
                    cursorColor: Color(0xFF161C39),
                    controller: name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                )
                    :
                Text(
                  name.text,
                  style: const TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.w400,
                   color: Color(0xFF161C39)
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Username (email)",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  child: Text(
                    username.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF161C39)
                      ),
                    ),


                    IconButton(
                      onPressed: ()=>{
                        setState((){
                          editPassword=true;
                        })
                      },
                      icon: const Icon(IconData(0xef8d, fontFamily: 'MaterialIcons'), color: Color(0xFF161C39), size: 20,)
                    )
                  ],
                ),
                editPassword
                ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO: add controllers
                    SizedBox(
                      width: 250,
                      child: TextField(
                        cursorColor: const Color(0xFF161C39),
                        controller: newPassword,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        cursorColor: const Color(0xFF161C39),
                        controller: repeatNewPassword,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                        decoration: const InputDecoration(
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:const MaterialStatePropertyAll<Color>(Color(0xFF161C39)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                            )
                          ),

                          onPressed: ()=>{

                          },
                          child: const Text("Change Password",style: TextStyle(color: Colors.white),)
                        ),
                      ),
                    )
                  ],
                )
                :
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    password.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),

              ],
            ),
            //PRACTICE INFORMATION
            Column(
              //direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Practice Information",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF161C39)
                      ),
                    ),
                    IconButton(
                      onPressed: ()=>{
                        setState((){
                          editPracticeInfo=true;
                        })
                      },
                      icon: const Icon(IconData(0xef8d, fontFamily: 'MaterialIcons'), color: Color(0xFF161C39),)
                    )
                  ],
                ),
                editPracticeInfo ?
                Column(
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        cursorColor: const Color(0xFF161C39),
                        controller: address,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                        decoration: const InputDecoration(
                          hintText: "Address 1",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        cursorColor: const Color(0xFF161C39),
                        controller: address2,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                        decoration: const InputDecoration(
                          hintText: "Address 2",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        cursorColor: const Color(0xFF161C39),
                        controller: city,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                        decoration: const InputDecoration(
                          hintText: "City",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        cursorColor: const Color(0xFF161C39),
                        controller: state,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                        decoration: const InputDecoration(
                          hintText: "State",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        cursorColor: const Color(0xFF161C39),
                        controller: zip,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                        decoration: const InputDecoration(
                          hintText: "ZIP",
                        ),
                      ),
                    )
                  ],
                )
                :
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "${address.text}, ${address2.text}\n${city.text}, ${state.text} ${zip.text}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                editPracticeInfo ?
                 const SizedBox(
                   height: 10,
                 )
                :
                const SizedBox(height: 0),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Dental Cleaning Flat Price",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                editPracticeInfo
                    ?
                SizedBox(
                  width: 250,
                  child: TextField(
                    cursorColor: const Color(0xFF161C39),
                    controller: price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                    decoration: const InputDecoration(
                      prefixText: "\$",
                    ),
                  ),
                )
                :
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "\$${price.text}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "*We use this to calculate discounts to bring in cash-paying, flexible patients",
                    softWrap: true,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
              ],
            ),
            //CONTACT INFO
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              //direction: Axis.vertical,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF161C39)
                      ),
                    ),
                    IconButton(
                      onPressed: ()=>{
                        setState((){
                          editContactInfo=true;
                        })
                      },
                      icon: const Icon(IconData(0xef8d, fontFamily: 'MaterialIcons'), color: Color(0xFF161C39),)
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                editContactInfo
                ?
                SizedBox(
                  width: 250,
                  child: TextField(
                    cursorColor: const Color(0xFF161C39),
                    controller: email,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    )
                  ),
                )
                :
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    email.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                editContactInfo
                ?
                SizedBox(
                  width: 250,
                  child: TextField(
                    cursorColor: const Color(0xFF161C39),
                    controller: phone,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    )
                  ),
                )
                :
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    phone.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "How would you like us to inform you of booked appointments?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children:[
                    Radio(
                      activeColor: const Color(0xFF161C39),
                      value: "Just email",
                      groupValue: contactType,
                      onChanged: editContactInfo ? (String? value) {
                        setState(() {
                          contactType = value!;
                        });
                      } : null,
                    ),
                      const Text(
                        "Just email",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children:[
                      Radio(
                        activeColor: const Color(0xFF161C39),
                        value: "Just text",
                        groupValue: contactType,
                        onChanged: editContactInfo ? (String? value) {
                          setState(() {
                            contactType = value!;
                          });
                        } : null,
                      ),
                      const Text(
                        "Just text",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children:[
                      Radio(
                        activeColor: const Color(0xFF161C39),
                        value: "Both email and text",
                        groupValue: contactType,
                        onChanged: editContactInfo ? (String? value) {
                          setState(() {
                            contactType = value!;
                          });
                        } : null,
                      ),
                      const Text(
                        "Both email and text",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161C39)
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            ),
            //BANK INFORMATION
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //direction: Axis.vertical,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Bank Information",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF161C39)
                      ),
                    ),
                    IconButton(onPressed: ()=>{}, icon: const Icon(IconData(0xef8d, fontFamily: 'MaterialIcons'), color: Color(0xFF161C39),))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Routing Number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    bankRouting.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Account Number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    bankAccount.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top:10.0),
                  child: Text(
                    "*We use your bank information to send you payment when patients book appointments at your practice.",
                    softWrap: true,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161C39)
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 0,
              width: 0,
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
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

                  onPressed: ()=>{

                  },
                  child: const Text("Save Updates",style: TextStyle(color: Colors.white),)
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}
