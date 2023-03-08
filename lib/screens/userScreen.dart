import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_2/components/key.dart';
import 'package:task_2/constants.dart';
import 'package:task_2/screens/add_user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late List users = [];

  Future<String> getData() async {
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('GET', Uri.parse('https://gorest.co.in/public/v2/users'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    users = jsonDecode(respStr);
    return 'Successfully Fetched data';
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('Add User');
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUser()),
          );
          if (result == 201) {
            setState(() {
              getData();
            });
          }
        },
        backgroundColor: const Color(0xff066163),
        child: const Icon(
          Icons.add,
          size: 25.0,
        ),
      ),
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: const Color(0xff383838),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: users == null ? 0 : users.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 6.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              users[index]['name'],
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              users[index]['email'],
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          users[index]['where'],
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
