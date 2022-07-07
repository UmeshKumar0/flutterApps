// ignore_for_file: unnecessary_this, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horoscope_app/colors/colors.dart';
import 'package:horoscope_app/screens/reset_password.dart';
import 'package:horoscope_app/screens/verify_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginemailController = TextEditingController();
  TextEditingController loginpassController = TextEditingController();
  TextEditingController signupemailController = TextEditingController();
  TextEditingController signuppassController = TextEditingController();

  late bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  int counter = 0;
  bool register = false;
  String? valueChoose;
  final listItems = [
    "Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Capricorn",
    "Aquarius",
    "Pisces"
  ];
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(child: LayoutBuilder(builder: (context, snapshot) {
          if (snapshot.maxWidth < 1268) {
            return Container(
              color: purpleColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  register == false
                      ? Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          width: w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 120,
                              ),
                              const Text(
                                "Horoscope App",
                                style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor),
                              ),
                              const Text(
                                "Sign into your account ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: greyColor),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 48.0, left: 48, right: 48),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp('[ ]')),
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
                                  controller: loginemailController,
                                  style: const TextStyle(
                                      color: whiteColor, fontSize: 20),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 48.0, left: 48, right: 48),
                                child: TextFormField(
                                  controller: loginpassController,
                                  style: const TextStyle(
                                      color: whiteColor, fontSize: 20),
                                  obscureText: !_passwordVisible,
                                  cursorColor: whiteColor,
                                  decoration: InputDecoration(
                                    iconColor: whiteColor,
                                    icon: const Icon(
                                      Icons.lock_outline,
                                      color: whiteColor,
                                    ),
                                    labelText: 'Password',
                                    helperText:
                                        'Password should be atleast 6 characters',
                                    helperStyle:
                                        const TextStyle(color: greyColor),
                                    labelStyle:
                                        const TextStyle(color: whiteColor),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_passwordVisible == false) {
                                            _passwordVisible = true;
                                          } else {
                                            _passwordVisible = false;
                                          }
                                        });
                                      },
                                      child: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 30,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              forgetPassword(context),
                              const SizedBox(
                                height: 80,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: signin,
                                  child: Container(
                                    width: w * 0.5,
                                    height: h * 0.08,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/loginbtn.png"),
                                            fit: BoxFit.cover)),
                                    child: const Center(
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.08,
                              ),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Don't have an account?  ",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              setState(() {
                                                loginemailController.clear();
                                                loginpassController.clear();
                                                _passwordVisible = false;
                                                register = true;
                                              });
                                            },
                                          text: "Create",
                                          style: const TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 25),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 120,
                                backgroundImage:
                                    AssetImage("assets/images/horoscope.png"),
                                backgroundColor: Colors.transparent,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "Register Here",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 48.0, left: 48, right: 48),
                                child: TextFormField(
                                  controller: signupemailController,
                                  style: const TextStyle(
                                      color: whiteColor, fontSize: 20),
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
                                      Icons.abc_outlined,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 48.0, left: 48, right: 48),
                                child: TextFormField(
                                  controller: signuppassController,
                                  style: const TextStyle(
                                      color: whiteColor, fontSize: 20),
                                  obscureText: !_passwordVisible,
                                  cursorColor: whiteColor,
                                  decoration: InputDecoration(
                                    iconColor: whiteColor,
                                    icon: const Icon(
                                      Icons.lock_outline,
                                      color: whiteColor,
                                    ),
                                    labelText: 'Password',
                                    helperText:
                                        'Password should be atleast 6 characters',
                                    helperStyle:
                                        const TextStyle(color: greyColor),
                                    labelStyle:
                                        const TextStyle(color: whiteColor),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_passwordVisible == false) {
                                            _passwordVisible = true;
                                          } else {
                                            _passwordVisible = false;
                                          }
                                        });
                                      },
                                      child: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 30,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 48.0, left: 48, right: 48),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Sign",
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    DropdownButton<String>(
                                        style:
                                            const TextStyle(color: whiteColor),
                                        dropdownColor: darkBlueColor,
                                        hint: Text(
                                          "Choose your Sign",
                                          style: TextStyle(
                                              color: Colors.grey[400]),
                                        ),
                                        value: valueChoose,
                                        icon: const Icon(
                                          Icons.arrow_drop_down_outlined,
                                          size: 36,
                                          color: whiteColor,
                                        ),
                                        items: listItems
                                            .map(buildMenuItem)
                                            .toList(),
                                        onChanged: (value) => setState(() {
                                              if (value != null) {
                                                this.valueChoose = value;
                                              } else {}
                                            })),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 90,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: singup,
                                  child: Container(
                                    width: w * 0.5,
                                    height: h * 0.08,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/loginbtn.png"),
                                            fit: BoxFit.cover)),
                                    child: const Center(
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.05,
                              ),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Already have an account?  ",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              setState(() {
                                                signupemailController.clear();
                                                signuppassController.clear();
                                                valueChoose = "Aries";
                                                _passwordVisible = false;
                                                register = false;
                                              });
                                            },
                                          text: "Sign In",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 25),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            );
          } else {
            return Container(
              color: purpleColor,
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.05,
                  ),
                  register == false
                      ? Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          width: w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Horoscope App",
                                style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor),
                              ),
                              const Text(
                                "Sign into your account ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: greyColor),
                              ),
                              SizedBox(
                                height: h * 0.15,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp('[ ]')),
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
                                        controller: loginemailController,
                                        style: const TextStyle(
                                            color: whiteColor, fontSize: 20),
                                        cursorColor: whiteColor,
                                        decoration: const InputDecoration(
                                          iconColor: whiteColor,
                                          icon: Icon(
                                            Icons.email,
                                            color: whiteColor,
                                          ),
                                          labelText: 'Email',
                                          labelStyle:
                                              TextStyle(color: whiteColor),
                                          helperText: 'Enter a valid Email',
                                          helperStyle:
                                              TextStyle(color: greyColor),
                                          suffixIcon: Icon(
                                            Icons.abc_rounded,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: TextFormField(
                                        controller: loginpassController,
                                        style: const TextStyle(
                                            color: whiteColor, fontSize: 20),
                                        obscureText: !_passwordVisible,
                                        cursorColor: whiteColor,
                                        decoration: InputDecoration(
                                          iconColor: whiteColor,
                                          icon: const Icon(
                                            Icons.lock_outline,
                                            color: whiteColor,
                                          ),
                                          labelText: 'Password',
                                          helperText:
                                              'Password should be atleast 6 characters',
                                          helperStyle:
                                              const TextStyle(color: greyColor),
                                          labelStyle: const TextStyle(
                                              color: whiteColor),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_passwordVisible == false) {
                                                  _passwordVisible = true;
                                                } else {
                                                  _passwordVisible = false;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: 30,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 120,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: signin,
                                  child: Container(
                                    width: w * 0.2,
                                    height: h * 0.1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/loginbtn.png"),
                                            fit: BoxFit.cover)),
                                    child: const Center(
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.08,
                              ),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Don't have an account?  ",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 20),
                                      children: [
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              setState(() {
                                                loginemailController.clear();
                                                loginpassController.clear();
                                                _passwordVisible = false;
                                                register = true;
                                              });
                                            },
                                          text: "Create",
                                          style: const TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 25),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Row(
                            children: [
                              Flexible(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: h * 0.2,
                                      width: w * 0.4,
                                    ),
                                    const CircleAvatar(
                                      radius: 120,
                                      backgroundImage: AssetImage(
                                          "assets/images/horoscope.png"),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    const Text(
                                      "Register Here",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w500,
                                          color: whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 48.0, left: 48, right: 48),
                                      child: TextFormField(
                                        controller: signupemailController,
                                        style: const TextStyle(
                                            color: whiteColor, fontSize: 20),
                                        cursorColor: whiteColor,
                                        decoration: const InputDecoration(
                                          iconColor: whiteColor,
                                          icon: Icon(
                                            Icons.email,
                                            color: whiteColor,
                                          ),
                                          labelText: 'Email',
                                          labelStyle:
                                              TextStyle(color: whiteColor),
                                          helperText: 'Enter a valid Email',
                                          helperStyle:
                                              TextStyle(color: greyColor),
                                          suffixIcon: Icon(
                                            Icons.abc_outlined,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 48.0, left: 48, right: 48),
                                      child: TextFormField(
                                        controller: signuppassController,
                                        style: const TextStyle(
                                            color: whiteColor, fontSize: 20),
                                        obscureText: !_passwordVisible,
                                        cursorColor: whiteColor,
                                        decoration: InputDecoration(
                                          iconColor: whiteColor,
                                          icon: const Icon(
                                            Icons.lock_outline,
                                            color: whiteColor,
                                          ),
                                          labelText: 'Password',
                                          helperText:
                                              'Password should be atleast 6 characters',
                                          helperStyle:
                                              const TextStyle(color: greyColor),
                                          labelStyle: const TextStyle(
                                              color: whiteColor),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_passwordVisible == false) {
                                                  _passwordVisible = true;
                                                } else {
                                                  _passwordVisible = false;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: 30,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 48.0, left: 48, right: 48),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Sign",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              DropdownButton<String>(
                                                  style: const TextStyle(
                                                      color: whiteColor),
                                                  dropdownColor: darkBlueColor,
                                                  hint: Text(
                                                    "Choose your Sign",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[400]),
                                                  ),
                                                  value: valueChoose,
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    size: 36,
                                                    color: whiteColor,
                                                  ),
                                                  items: listItems
                                                      .map(buildMenuItem)
                                                      .toList(),
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        if (value != null) {
                                                          this.valueChoose =
                                                              value;
                                                        } else {}
                                                      })),
                                            ],
                                          ),
                                          SizedBox(
                                            height: h * 0.1,
                                          ),
                                          Center(
                                            child: InkWell(
                                              onTap: singup,
                                              child: Container(
                                                width: w * 0.3,
                                                height: h * 0.1,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    image: const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/loginbtn.png"),
                                                        fit: BoxFit.cover)),
                                                child: const Center(
                                                  child: Text(
                                                    "Register",
                                                    style: TextStyle(
                                                        color: whiteColor,
                                                        fontSize: 50,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.05,
                                          ),
                                          Center(
                                            child: RichText(
                                              text: TextSpan(
                                                  text:
                                                      "Already have an account?  ",
                                                  style: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: 20),
                                                  children: [
                                                    TextSpan(
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              setState(() {
                                                                signupemailController
                                                                    .clear();
                                                                signuppassController
                                                                    .clear();
                                                                valueChoose =
                                                                    "Aries";
                                                                _passwordVisible =
                                                                    false;
                                                                register =
                                                                    false;
                                                              });
                                                            },
                                                      text: "Sign In",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 25),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            );
          }
        })));
  }

  singup() {
    if (valueChoose != null) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: signupemailController.text.trim(),
              password: signuppassController.text.trim())
          .then((value) async {
        print("Created Account");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => VerifyEmail(
                name: valueChoose.toString(),
                imageLoc:
                    "assets/images/${valueChoose.toString().toLowerCase()}.png",
                pass: signuppassController.text,
                user: signupemailController.text)
            //  MyHomeScreen(
            //       name: valueChoose.toString(),
            //       imageLoc:
            //           "assets/images/${valueChoose.toString().toLowerCase()}.png",
            //     )
            ,
          ),
        );
      }).onError((error, stackTrace) {
        final splitted = error.toString().split(r"]");
        String e = splitted[1];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e),
        ));
        print("Error$error");
      });
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Sign can't be empty"),
      ));
    }
  }

  signin() async {
    String pass = loginpassController.text;
    String user = loginemailController.text;

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: loginemailController.text,
            password: loginpassController.text)
        .then((value) async {
      print("Signed In !! successfully");
      String cd = loginemailController.text;

      DocumentSnapshot ab = await FirebaseFirestore.instance
          .collection("profileInfo")
          .doc(cd)
          .get();
      String ef = ab['sign'];
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('key', loginemailController.text);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (builder) =>
                  // MyHomeScreen(name: ef, imageLoc: "assets/images/$ef.png")
                  VerifyEmail(
                      name: ef,
                      imageLoc: "assets/images/$ef.png",
                      pass: pass,
                      user: user)));
      print("Navigate");
    }).onError((error, stackTrace) {
      final splitted = error.toString().split(r"]");

      if (splitted.length > 1) {
        print(splitted);
        if (splitted[1].contains("password")) {
          counter++;
          print(counter);
          if (counter > 3) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Maximum Attempt reached , Try after some time"),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Credentials doesn't match from the database"),
            ));
          }
        } else if (splitted[1].contains("unusual")) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Blocked all requests from this device due to unusual activity. Try again later."),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Credentials doesn't match from the database"),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email not registered yet, Please register first"),
        ));
      }

      print("Error : $error");
    });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      );

  Widget forgetPassword(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 40),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => ResetPassword()));
        },
        child: const Text(
          "Forget Password ?",
          textAlign: TextAlign.right,
          style: TextStyle(
              color: greyColor,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
