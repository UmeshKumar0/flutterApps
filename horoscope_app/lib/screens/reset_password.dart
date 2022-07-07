// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horoscope_app/colors/colors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        backgroundColor: purpleColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: purpleColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48.0, left: 48, right: 48),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                validator: (value) {
                  if (value!.isEmpty ||
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                          .hasMatch(value)) {
                    return "Enter correct Email";
                  } else {
                    return null;
                  }
                },
                controller: _emailController,
                style: const TextStyle(color: whiteColor, fontSize: 20),
                cursorColor: whiteColor,
                decoration: const InputDecoration(
                  iconColor: whiteColor,
                  icon: Icon(
                    Icons.email,
                    color: whiteColor,
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: whiteColor),
                  helperText: 'Enter a valid Email',
                  helperStyle: TextStyle(color: greyColor),
                  suffixIcon: Icon(
                    Icons.abc_rounded,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.1,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  try {
                    print(_emailController.text);
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailController.text)
                        .then((value) => Navigator.of(context).pop())
                        .onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Email not correct"),
                      ));
                    });
                  } on FirebaseAuthException catch (e) {
                    print("Hello World");
                    print(e.code);
                    print(e.message);
                  }
                },
                child: Container(
                  width: w * 0.5,
                  height: h * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/loginbtn.png"),
                          fit: BoxFit.cover)),
                  child: const Center(
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
