// ignore_for_file: deprecated_member_use, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:post_api_app/login_sharedPref/helpers/sp_helper.dart';
import 'package:post_api_app/login_sharedPref/screens/login_page.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://github.com/resulcay/signup_page/blob/master/assets/images/register.png?raw=true'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 50),
            child: const Text(
              "Welcome Admin",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.27),
              child: Column(children: [
                Text(
                  "How's your day !",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "I have never in my life learned anything from any man who agreed with me.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 17),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "In every day, there are 1,440 minutes. That means we have 1,440 daily opportunities to make a positive impact.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 17),
                ),
                const SizedBox(
                  height: 120,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xff4c505b),
                    child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          SharedPreferenceHelper().logoutAuthToken();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext ctx) => MyLogin()));
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                ]),
                const SizedBox(
                  height: 40,
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
