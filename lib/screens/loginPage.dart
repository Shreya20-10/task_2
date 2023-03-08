import 'package:flutter/material.dart';
import 'package:task_2/constants.dart';
import 'package:task_2/screens/userScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String dropdownValue = 'Facebook';
  String enteredUserName = '';
  String enteredEmail = '';

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Image(
                image: AssetImage("assets/images/user.png"),
                // height: 100,
                // width: 100,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  enteredUserName = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Username',
                ),
              ),
            ),

            
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  enteredEmail = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Email Address',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor:Color(0xff066163),),
              onPressed: () {
                if (enteredEmail == 'admin@gmail.com' &&
                    enteredUserName == 'admin') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 2000),
                      content: Text(
                        'Invalid Details!',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      backgroundColor: Color(0xffCDBE78),
                    ),
                  );
                }
              },
              child: Text(
                "Log In",
                //style: TextStyle(),
              ),
            )


          ],
        ),
      ),
    );
  }
}



// DropdownButton<String>(
// value: dropdownValue,
// items: <String>[
// 'Facebook',
// 'Instagram',
// 'Organic',
// 'Friend',
// 'Google'
// ].map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(
// value,
// style: TextStyle(fontSize: 30),
// ),
// );
// }).toList(),
// onChanged: (String? newValue) {
// setState(() {
// dropdownValue:
// newValue!;
// });
// },
// ),
// Text(
// 'Selected Value: $dropdownValue',
// style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
// ),
