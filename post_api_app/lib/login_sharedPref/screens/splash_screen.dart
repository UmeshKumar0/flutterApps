// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:post_api_app/login_sharedPref/helpers/sp_helper.dart';
import 'package:post_api_app/login_sharedPref/screens/home_page.dart';
import 'package:post_api_app/login_sharedPref/screens/login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    doLogin();
    super.initState();
  }

  void doLogin() async {
    Future.delayed(Duration(seconds: 3), () async {
      final token = await SharedPreferenceHelper().getAuthToken();
      if (token != null && token.isNotEmpty) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyRegister()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyLogin()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
