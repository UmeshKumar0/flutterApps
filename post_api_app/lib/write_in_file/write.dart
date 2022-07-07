// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_new, unnecessary_string_interpolations, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, duplicate_ignore
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class WriteFile extends StatefulWidget {
  const WriteFile({
    Key? key,
    required this.storage,
  }) : super(key: key);
  final Storage storage;

  @override
  State<WriteFile> createState() => _WriteFileState();
}

class _WriteFileState extends State<WriteFile> {
  TextEditingController datacontroller = TextEditingController();
  String? state;
  Future<Directory>? _appDocDir;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
  }

  Future<File> writeData() async {
    setState(() {
      state = datacontroller.text;
      datacontroller.text = "";
    });
    return widget.storage.writeData(state!);
  }

  void getDirect() {
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

  Future<Future<OpenResult>> openFile() async {
    return OpenFile.open("$_appDocDir/sample.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Write In File",
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            0.1,
            0.4,
            0.6,
            0.9,
          ],
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
            Colors.yellow,
            Colors.red,
            Colors.brown,
            Colors.teal,
          ],
        )),
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Write Operations App",
                  style: TextStyle(
                      fontSize: 35,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 90,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    decoration: new InputDecoration(
                        hintText: 'Write Something !!',
                        border: InputBorder.none,
                        icon: Icon(Icons.data_array)),
                    controller: datacontroller,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: writeData,
                  child: Text("Write"),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Text(
                        "Text : ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Flexible(
                        child: Text(
                          " ${state ?? "File is Empty"}",
                          style: TextStyle(backgroundColor: Colors.green),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: getDirect,
                  child: Text("Get Directory"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white60,
                  child: FutureBuilder<Directory>(
                    builder: (BuildContext context,
                        AsyncSnapshot<Directory> snapshot) {
                      Text text = Text("");
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          text = Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          text = Text("Path: ${snapshot.data!.path}");
                        } else {
                          text = Text("Unavaliable");
                        }
                      }
                      return new Container(
                        child: text,
                      );
                    },
                    future: _appDocDir,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    String newpath =
                        '/data/user/0/com.example.post_api_app/app_flutter/sample.txt';
                    print(newpath.toString());
                    OpenFile.open(newpath);
                  },
                  child: Text("Open File"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Storage {
  Future<String> get localPath async {
    final die = await getApplicationDocumentsDirectory();
    return die.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    print("$path");
    return File("$path/sample.txt");
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data", mode: FileMode.append);
  }
}
