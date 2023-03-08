import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:task_2/constants.dart';

import '../components/key.dart';



class AddUser extends StatelessWidget {
  //const AddUser({Key? key}) : super(key: key);
  late String name;
  late String email;
  late String where;
  late int id;
  late bool willAdd;

  AddUser(
      {this.email = '',
        this.name = '',
        this.where = '',
        this.id = 0}) {
    willAdd = name.isEmpty;
  }

  Future<int> addUser(
      String name, String email, String where) async {
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request =
    http.Request('POST', Uri.parse('https://gorest.co.in/public/v2/users'));
    request.body = json.encode(
        {"email": email, "name": name, "where": where,});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  Future<int> modifyUser(
      String name, String email, String where) async {
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PATCH', Uri.parse('https://gorest.co.in/public/v2/users/$id'));
    request.body = json.encode(
        {"email": email, "name": name, "where": where});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: const BoxDecoration(
            color: Color(0xffF2F2F2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  willAdd ? 'Add User' : 'Modify User',
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff383838),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: name.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: name),
                onChanged: (value) {
                  name = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter name.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: email.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: email),
                onChanged: (value) {
                  email = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter email.'),
              ),
              const SizedBox(
                height: 20.0,
              ),

              DropDownTextField(
                // initialValue: "name4",
                controller: SingleValueDropDownController,
                //where.isEmpty,
                clearOption: true,
                // enableSearch: true,
                // dropdownColor: Colors.green,
                searchDecoration: const InputDecoration(
                    hintText: "Where are you coming from"),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                dropDownItemCount: 5,

                dropDownList: const [
                  DropDownValueModel(name: 'Facebook', value: "Facebook"),
                  DropDownValueModel(name: 'Instagram', value: "Instagram"),
                  DropDownValueModel(name: 'Organic', value: "Organic"),
                  DropDownValueModel(name: 'Friend', value: "Friend"),
                  DropDownValueModel(name: 'Google', value: "Google"),
                ],
                onChanged: (val) {},
              ),



              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff066163),),
                onPressed: () async {
                  if (willAdd) {
                    if (email != '' &&
                        name != '' &&
                        where != '') {
                      int statusCode =
                      await addUser(name, email, where);
                      if (statusCode == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 2000),
                            content: Text(
                              'User added successFully',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 2000),
                            content: Text(
                              'Something went wrong, Please try again!',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                      Navigator.pop(context, statusCode);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'Fill all the details!',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          backgroundColor: Color(0xff066163),
                        ),
                      );
                    }
                  } else {
                    int statusCode =
                    await modifyUser(name, email, where);
                    if (statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'User Modified successFully',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'Something went wrong, Please try again!',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                    Navigator.pop(context, statusCode);
                  }
                },
                child: Text((willAdd)? 'Add' :  'Modify'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
