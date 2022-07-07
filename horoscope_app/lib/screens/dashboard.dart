import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horoscope_app/colors/colors.dart';
import 'package:horoscope_app/data/data.dart';
import 'package:horoscope_app/model/dataModel.dart';
import 'package:horoscope_app/screens/home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<DataModel> itemsList = List.of(menuInfo);

  void updateList(String value) {
    if (updateController.text == '') {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    setState(() {
      itemsList = menuInfo
          .where((element) => element.name.toLowerCase().contains(value))
          .toList();
    });
  }

  FocusNode yourFocusNode = FocusNode();
  bool ui = false;
  TextEditingController updateController = TextEditingController();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 1268) {
            return SingleChildScrollView(
              child: Container(
                height: h,
                color: purpleColor,
                child: Center(
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        const Text(
                          "Hello",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                        Text(
                          "Horoscope",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 60,
                              fontFamily: GoogleFonts.aBeeZee().fontFamily),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 500,
                          child: CupertinoSearchTextField(
                              controller: updateController,
                              focusNode: yourFocusNode,
                              placeholder: "Search Sign",
                              placeholderStyle:
                                  const TextStyle(color: whiteColor),
                              itemColor: greyColor,
                              padding: const EdgeInsets.all(20),
                              style: const TextStyle(color: whiteColor),
                              decoration: BoxDecoration(
                                color: purpleColor,
                                border: Border.all(color: greyColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onChanged: (value) {
                                updateList(value);
                              }),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: 500,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final sign = itemsList[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomeScreen(
                                                    name: sign.name,
                                                    imageLoc: sign.asset,
                                                  )));
                                    },
                                    child: Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          CircleAvatar(
                                            radius: 60,
                                            backgroundColor:
                                                itemsList[index].color,
                                            child: Image.asset(
                                              sign.asset,
                                              width: 300,
                                              height: 300,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            itemsList[index].name,
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontFamily: GoogleFonts
                                                        .robotoCondensed()
                                                    .fontFamily),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            sign.date,
                                            style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.manrope()
                                                        .fontFamily,
                                                color: greyColor),
                                          ),
                                          const SizedBox(
                                            height: 70,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: itemsList.length,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                height: h,
                color: purpleColor,
                child: Center(
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * 0.04,
                        ),
                        const Text(
                          "Hello",
                          style: TextStyle(color: whiteColor, fontSize: 20),
                        ),
                        Text(
                          "Horoscope",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 60,
                              fontFamily: GoogleFonts.aBeeZee().fontFamily),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 500,
                          child: CupertinoSearchTextField(
                              controller: updateController,
                              focusNode: yourFocusNode,
                              placeholder: "Search Sign",
                              placeholderStyle:
                                  const TextStyle(color: whiteColor),
                              itemColor: greyColor,
                              padding: const EdgeInsets.all(20),
                              style: const TextStyle(color: whiteColor),
                              decoration: BoxDecoration(
                                color: purpleColor,
                                border: Border.all(color: greyColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onChanged: (value) {
                                updateList(value);
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: h * 0.6,
                          width: w * 0.7,
                          child: GridView.builder(
                            itemBuilder: (context, index) {
                              final sign = itemsList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomeScreen(
                                                    name: sign.name,
                                                    imageLoc: sign.asset,
                                                  )));
                                    },
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: h * 0.03,
                                          ),
                                          CircleAvatar(
                                            radius: 60,
                                            backgroundColor:
                                                itemsList[index].color,
                                            child: Image.asset(
                                              sign.asset,
                                              width: 300,
                                              height: 300,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            itemsList[index].name,
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontFamily: GoogleFonts
                                                        .robotoCondensed()
                                                    .fontFamily),
                                          ),
                                          SizedBox(
                                            height: h * 0.03,
                                          ),
                                          Text(
                                            sign.date,
                                            style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.manrope()
                                                        .fontFamily,
                                                color: greyColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: itemsList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
