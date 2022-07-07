// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:post_api_app/db/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class EditToDoScreen extends StatefulWidget {
  const EditToDoScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  }) : super(key: key);
  final String id;
  final String title;
  final String description;
  final String date;

  @override
  State<EditToDoScreen> createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDoScreen> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _datecontroller = TextEditingController();

  @override
  void initState() {
    _titlecontroller.text = widget.title;
    _descriptioncontroller.text = widget.description;
    _datecontroller.text = widget.date;
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

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
    final  todoprovider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              TextField(
                controller: _titlecontroller,
                decoration: const InputDecoration(
                  hintText: "Title here",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              TextField(
                controller: _descriptioncontroller,
                decoration: const InputDecoration(
                  hintText: "Description here",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              TextField(
                controller: _datecontroller,
                decoration: const InputDecoration(
                  hintText: "Date here",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await todoprovider.updateTitle(
                      widget.id,
                      _titlecontroller.text,
                    );
                    await todoprovider.updateDescription(
                      widget.id,
                      _descriptioncontroller.text,
                    );
                    await todoprovider.updateDate(
                      widget.id,
                      _datecontroller.text,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}
