// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, avoid_print
import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horoscope_app/colors/colors.dart';
import 'package:horoscope_app/data/database.dart';
import 'package:horoscope_app/model/menu_item_model.dart';
import 'package:horoscope_app/screens/dashboard.dart';
import 'package:horoscope_app/screens/login_screen.dart';
import 'package:horoscope_app/screens/splash_screen.dart';
import 'package:horoscope_app/widgets/menu_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../model/itemmodel.dart';

class MyHomeScreen extends StatefulWidget {
  final String name;
  final String imageLoc;
  const MyHomeScreen({
    Key? key,
    required this.name,
    required this.imageLoc,
  }) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  Future<ItemModel?> createItem(String sign, String day) async {
    final String apiUrl =
        "https://aztro.sameerkumar.website/?sign=$sign&day=$day";
    final response = await http.post(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      final itemModel = itemModelFromJson(responseString);

      return itemModel;
    } else {
      return null;
    }
  }

  List userProfile = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    dynamic result = await DatabaseManager().getData();

    if (result == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        userProfile = result;
      });
    }
  }

  late String valueChoose1 = '';
  late String valueChoose = "Today";
  List listitems = ['Today', 'Tomorrow'];
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: createItem(
          widget.name, valueChoose1 == '' ? valueChoose : valueChoose1),
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 1268) {
                return Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: blueColor,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "$finalEmail",
                                        style: const TextStyle(
                                            color: whiteColor, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  PopupMenuButton<MenuItem1>(
                                      onSelected: (item) =>
                                          onSelected(context, item),
                                      iconSize: 40,
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: whiteColor,
                                      ),
                                      itemBuilder: (context) => [
                                            ...MenuItems.itemFirst
                                                .map(buildItem)
                                                .toList()
                                          ]),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 90,
                                  backgroundColor: blueColor,
                                  child: Image.asset(widget.imageLoc),
                                ),
                              ],
                            ),
                            Text(
                              StringUtils.capitalize(widget.name),
                              style: const TextStyle(
                                  color: whiteColor, fontSize: 50),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!.currentDate,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontFamily: GoogleFonts.abel().fontFamily,
                                  fontSize: 30),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: Container(
                          color: whiteColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    dropdownColor: whiteColor,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle_rounded),
                                    iconSize: 36,
                                    isExpanded: true,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                    ),
                                    items: listitems.map((valueItem) {
                                      return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(valueItem),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        valueChoose = newValue.toString();
                                        valueChoose1 = newValue.toString();
                                        createItem(widget.name, valueChoose1);
                                      });
                                    },
                                    value: valueChoose,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                "Number And Time",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: GoogleFonts.arvo().fontFamily),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Lucky Number",
                                        style: TextStyle(
                                          color: blueColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.number_circle,
                                            color: blueColor,
                                          ),
                                          Text(
                                            " ${snapshot.data!.luckyNumber}",
                                            style: TextStyle(
                                                fontFamily: GoogleFonts.abel()
                                                    .fontFamily,
                                                color: blueColor,
                                                fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "Lucky Time",
                                        style: TextStyle(
                                          color: orangeColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.time,
                                            color: orangeColor,
                                          ),
                                          //
                                          Text(
                                            " ${snapshot.data!.luckyTime}",
                                            style: TextStyle(
                                                fontFamily: GoogleFonts.abel()
                                                    .fontFamily,
                                                color: orangeColor,
                                                fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Text(
                                "General Horoscope",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: GoogleFonts.arvo().fontFamily),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    top: 20, left: 40, right: 40),
                                margin: const EdgeInsets.only(
                                    top: 30, left: 50, right: 50),
                                child: Text(
                                  snapshot.data!.description,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      height: 2,
                                      letterSpacing: 1),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Color",
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.abel().fontFamily,
                                            color: Colors.grey,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        snapshot.data!.color,
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.abel().fontFamily,
                                            color: blueColor,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Nature",
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.abel().fontFamily,
                                            color: Colors.grey,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        snapshot.data!.mood,
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.abel().fontFamily,
                                            color: orangeColor,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Compatibility",
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.abel().fontFamily,
                                            color: Colors.grey,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        snapshot.data!.compatibility,
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.abel().fontFamily,
                                            color: Vx.green600,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: blueColor,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "$finalEmail",
                                        style: const TextStyle(
                                            color: whiteColor, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  PopupMenuButton<MenuItem1>(
                                      onSelected: (item) =>
                                          onSelected(context, item),
                                      iconSize: 30,
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: whiteColor,
                                      ),
                                      itemBuilder: (context) => [
                                            ...MenuItems.itemFirst
                                                .map(buildItem)
                                                .toList()
                                          ]),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 80,
                                  backgroundColor: blueColor,
                                  child: Image.asset(widget.imageLoc),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      StringUtils.capitalize(widget.name),
                                      style: const TextStyle(
                                          color: whiteColor, fontSize: 50),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data!.currentDate,
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontFamily:
                                              GoogleFonts.abel().fontFamily,
                                          fontSize: 30),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: Container(
                            color: whiteColor,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    width: w / 3,
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: DropdownButton(
                                      underline: const SizedBox(),
                                      dropdownColor: whiteColor,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_circle_rounded),
                                      iconSize: 36,
                                      isExpanded: true,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                      ),
                                      items: listitems.map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Text(valueItem),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          valueChoose = newValue.toString();
                                          valueChoose1 = newValue.toString();
                                          createItem(widget.name, valueChoose1);
                                        });
                                      },
                                      value: valueChoose,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(children: [
                                        Text(
                                          "Number And Time",
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontFamily: GoogleFonts.arvo()
                                                  .fontFamily),
                                        ),
                                        SizedBox(
                                          height: h * 0.05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                const Text(
                                                  "Lucky Number",
                                                  style: TextStyle(
                                                    color: blueColor,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      CupertinoIcons
                                                          .number_circle,
                                                      color: blueColor,
                                                    ),
                                                    Text(
                                                      " ${snapshot.data!.luckyNumber}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              GoogleFonts.abel()
                                                                  .fontFamily,
                                                          color: blueColor,
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  "Lucky Time",
                                                  style: TextStyle(
                                                    color: orangeColor,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      CupertinoIcons.time,
                                                      color: orangeColor,
                                                    ),
                                                    //
                                                    Text(
                                                      " ${snapshot.data!.luckyTime}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              GoogleFonts.abel()
                                                                  .fontFamily,
                                                          color: orangeColor,
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h * 0.05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Color",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.abel()
                                                              .fontFamily,
                                                      color: Colors.grey,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  snapshot.data!.color,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.abel()
                                                              .fontFamily,
                                                      color: blueColor,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Nature",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.abel()
                                                              .fontFamily,
                                                      color: Colors.grey,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  snapshot.data!.mood,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.abel()
                                                              .fontFamily,
                                                      color: orangeColor,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Compatibility",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.abel()
                                                              .fontFamily,
                                                      color: Colors.grey,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  snapshot.data!.compatibility,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.abel()
                                                              .fontFamily,
                                                      color: Vx.green600,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Text(
                                            "General Horoscope",
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontFamily: GoogleFonts.arvo()
                                                    .fontFamily),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 40, right: 40),
                                            margin: const EdgeInsets.only(
                                                top: 30, left: 50, right: 50),
                                            child: Text(
                                              snapshot.data!.description,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  height: 2,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )))
                  ],
                );
              }
            }),
          );
        } else {
          return SplashScreen();
        }
      },
    );
  }

  PopupMenuItem<MenuItem1> buildItem(MenuItem1 item) =>
      PopupMenuItem<MenuItem1>(
          value: item,
          child: Row(
            children: [
              Icon(
                item.icon,
                color: Colors.black,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(item.text),
            ],
          ));

  Future<void> onSelected(BuildContext context, MenuItem1 item) async {
    switch (item) {
      case MenuItems.itemSearch:
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => const Dashboard()));
        break;
      case MenuItems.itemLogout:
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.remove("key");
        FirebaseAuth.instance.signOut().then((value) {
          print("Signed Out");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (builder) => const LoginPage(),
              ),
              (route) => false);
        });

        break;
    }
  }
}
