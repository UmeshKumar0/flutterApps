// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/colors/colors.dart';
import 'package:horoscope_app/screens/home_screen.dart';
import 'package:horoscope_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

String? finalEmail;
String? finalSign;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getValidation().whenComplete(() async {
      Timer(const Duration(seconds: 2), () async {
        if (finalEmail == null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (b) => const LoginPage()));
        } else {
          String cd = finalEmail!;

          DocumentSnapshot ab = await FirebaseFirestore.instance
              .collection("profileInfo")
              .doc(cd)
              .get();
          String ef = ab['sign'];

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (b) => MyHomeScreen(
                      name: ef, imageLoc: "assets/images/$ef.png")));
        }
      });
    });

    // ignore: todo
    // TODO: implement initState
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('key');
    var obtainedSign = sharedPreferences.getString('setsign');
    setState(() {
      finalEmail = obtainedEmail!;
      finalSign = obtainedSign!;
    });
    print(finalEmail);
    print(finalSign);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: darkBlueColor),
      ),
    );
  }
}
