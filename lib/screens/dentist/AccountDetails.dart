import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);
  @override
  _AccountDetails createState() => _AccountDetails();
}
class _AccountDetails extends State<AccountDetails> {
  String contactType = "Just email";
  var name = 'Rock Canyon Dental';
  var address = '123 Place Rd.\n Provo, UT 84606';
  var username = 'Dentist123';
  var password = "*********";
  var email = "dentist@dental.com";
  var phone = "801 123 4567";
  var price = "120";
  var bankRouting = "123456789";
  var bankAccount = "*******1234";
  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      columnSizes: [1.fr, 1.fr],
      rowSizes: const [auto, auto, auto],
      //rowGap: 40,
      //columnGap: 24,
      children: [
        //DENTAL PRACTICE
        Wrap(
          direction: Axis.vertical,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Dental Practice",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF161C39)
                  ),
                ),
                IconButton(onPressed: ()=>{}, icon: const Icon(IconData(0xef8d, fontFamily: 'MaterialIcons'), color: Color(0xFF161C39),))
              ],
            ),
            const Text(
              "Rock Canyon Dental",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF161C39)
              ),
            ),
          ],
        ),
        //PRACTICE ADDRESS
        Wrap(
          direction: Axis.vertical,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Practice Address",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF161C39)
                  ),
                ),
                IconButton(onPressed: ()=>{}, icon: const Icon(IconData(0xef8d, fontFamily: 'MaterialIcons'), color: Color(0xFF161C39),))
              ],
            ),
            Text(
              address,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xFF161C39)
              ),
            ),
          ],
        ),
        //ACCOUNT INFO
        Wrap(
          direction: Axis.vertical,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Account Info",
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
                "Username",
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
                username,
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
                "Password",
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
                password,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF161C39)
                ),
              ),
            ),
          ],
        ),
        //DENTAL CLEANING PRICE
        Wrap(
          direction: Axis.vertical,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Dental Cleaning Price",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF161C39)
                  ),
                ),
                IconButton(onPressed: ()=>{}, icon: const Icon(IconData(0xef8d, fontFamily: 'MaterialIcons'), color: Color(0xFF161C39),))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\$$price",
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
                "*We use this to calculate discounts to bring\nin cash-paying, flexible patients",
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
        Wrap(
          direction: Axis.vertical,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Contact Info",
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
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                email,
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
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                phone,
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
                "How would you like us to infrom\nyou of booked appointments?",
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
                  onChanged: (String? value) {
                    setState(() {
                      contactType = value!;
                    });
                  },
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
                    onChanged: (String? value) {
                      setState(() {
                        contactType = value!;
                      });
                    },
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
                    onChanged: (String? value) {
                      setState(() {
                        contactType = value!;
                      });
                    },
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
        Wrap(
          direction: Axis.vertical,
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
                bankRouting,
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
                bankAccount,
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
                "*We use your bank information to send you\npayment when patients book appointments\nat your practice.",
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
      ]
    );
  }
}
