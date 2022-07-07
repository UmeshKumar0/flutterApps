// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:post_api_app/db/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import 'screens/show_todo_screen.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
        ),
      ],
      builder: (context,child)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ShowToDoScreen(),
      ),
    );
  }
}
