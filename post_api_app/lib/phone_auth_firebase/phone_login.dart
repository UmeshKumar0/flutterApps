import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreenFire extends StatefulWidget {
  const LoginScreenFire({Key? key}) : super(key: key);

  @override
  State<LoginScreenFire> createState() => _LoginScreenFireState();
}

class _LoginScreenFireState extends State<LoginScreenFire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text(
                "Phone Authentication",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
