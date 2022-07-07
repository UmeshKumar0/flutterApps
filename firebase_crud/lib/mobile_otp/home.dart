// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String name;

  const HomePage({super.key, required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.brown[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thank You  \n",
                  ),
                  Text("${widget.name}",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                  Text("\n  for registering with us"),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Image.network(
                  "https://www.nicepng.com/png/detail/990-9902707_free-png-thank-you-minions-png-image-with.png",
                  width: 300,
                  height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
