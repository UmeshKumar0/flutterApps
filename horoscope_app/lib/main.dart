import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/routes/routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: MyRoutes.route,
      debugShowCheckedModeBanner: false,
    );
  }
}
