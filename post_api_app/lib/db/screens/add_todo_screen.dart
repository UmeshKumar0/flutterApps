// ignore_for_file: unused_local_variable, prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:post_api_app/db/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({Key? key}) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  @override
  void dispose() {
    _titlecontroller.dispose();
    _descriptioncontroller.dispose();
    _datecontroller.dispose();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final toDoprovider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(children: [
            SizedBox(height: 20),
            TextField(
              controller: _titlecontroller,
              decoration: InputDecoration(
                hintText: "Title here",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptioncontroller,
              decoration: InputDecoration(
                hintText: "Description here",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _datecontroller,
              decoration: InputDecoration(
                hintText: "Date here",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await toDoprovider.insertData(_titlecontroller.text,
                    _descriptioncontroller.text, _datecontroller.text);
                _titlecontroller.clear();
                _descriptioncontroller.clear();
                _datecontroller.clear();
                Navigator.pop(context);
              },
              child: Text("Insert"),
            )
          ]),
        ),
      ),
    );
  }
}
