// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields

import 'package:firebase_crud/mobile_otp/otp.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Phone Auth"),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.teal[200],
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      'Register',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Name",
                        prefix: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Name : "),
                        )),
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                  child: Container(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefix: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("+91"),
                      ),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                  )),
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                  phone: _phoneController.text,
                                  name: _nameController.text,
                                )));
                        setState(() {});
                      },
                      child: Text("Login")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
