// ignore_for_file: public_member_api_docs, sort_constructors_first, curly_braces_in_flow_control_structures
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:horoscope_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/database.dart';

class VerifyEmail extends StatefulWidget {
  final String name;
  final String pass;
  final String user;
  final String imageLoc;
  const VerifyEmail({
    Key? key,
    required this.name,
    required this.imageLoc,
    required this.pass,
    required this.user,
  }) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MyHomeScreen(name: widget.name, imageLoc: widget.imageLoc)
      : Scaffold(
          appBar: AppBar(
            title: const Text("Verify Email"),
          ),
          body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "A verification email has been sent to you registered Email\n Go through Junk mails too ",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton.icon(
                        onPressed:
                            canResendEmail ? sendVerificationEmail : null,
                        icon: const Icon(Icons.email_rounded),
                        label: const Text(
                          "Resent Email",
                          style: TextStyle(fontSize: 24),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                )),
          ),
        );

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Email Cannot be verified'),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      final SharedPreferences sharedPreferences1 =
          await SharedPreferences.getInstance();
      sharedPreferences1.setString('key', widget.user);
      sharedPreferences1.setString(
          'setsign', widget.name.toLowerCase().toString());
      DatabaseManager()
          .createData(widget.user, widget.name.toLowerCase().toString())
          .onError((error, stackTrace) {
        print("Database Error =: $error");
      });

      timer?.cancel();
    }
  }
}
