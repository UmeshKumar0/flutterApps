// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore, avoid_print
import 'package:flutter/material.dart';
import 'package:post_api_app/Interactive_View/interactive_page.dart';
import 'package:post_api_app/bottomSheet/bottom_page.dart';
import 'package:post_api_app/utils/routes.dart';

void main() async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: MyRoutes.routes,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomSheetScreen());
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool isSwitched = false;
//   @override
//   Widget build(BuildContext context) {
    
    // Scaffold(
    //     appBar: AppBar(
    //       title: Text(widget.title),
    //       actions: [
    //         Row(
    //           children: [
    //             Text(
    //               isSwitched ? "Put" : "Post",
    //               style: TextStyle(
    //                 fontSize: 25,
    //               ),
    //             ),
    //             Switch(
    //               value: isSwitched,
    //               activeColor: Colors.white,
    //               onChanged: (value) {
    //                 print("VALUE : $value");
    //                 setState(() {
    //                   isSwitched = value;
    //                 });
    //               },
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //     body: NoteList()); //(isSwitched) ? PutPage() : HomeWidget());
//   }
// }
