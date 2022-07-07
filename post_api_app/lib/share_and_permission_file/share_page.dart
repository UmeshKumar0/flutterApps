// ignore_for_file: prefer_const_constructors, unused_field, library_prefixes

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:post_api_app/share_and_permission_file/location.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ShareScreen> {
  TextEditingController textdata = TextEditingController();
  final Location location = Location();
  PermissionStatus? _permissionGranted;

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(18),
            child: TextField(
              controller: textdata,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                label: Text("Enter Message"),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                if (textdata.value.text.isNotEmpty) {
                  await Share.share(textdata.text);
                } else {
                  const snackBar = SnackBar(
                    content: Text('Text is Empty'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text("Share Text")),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Icon(Icons.file_copy),
              // SizedBox(
              //   width: 30,
              // ),

              ElevatedButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    List<String>? files = result?.files
                        .map((e) => e.path)
                        .cast<String>()
                        .toList();
                    if (files == null) return;
                    await Share.shareFiles(files);
                  },
                  child: Text("Share File ")),
              Spacer(
                flex: 1,
              )
            ],
          ),
          SizedBox(
            height: 140,
          ),
          Text(
            "Permission Status : ${_permissionGranted ?? "unknown"}",
            style: TextStyle(fontSize: 17, color: Colors.black87),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => _requestPermission(),
            child: Text("Request Permission"),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocationScreen()),
              );
            },
            child: Text("Location"),
          ),
        ],
      ),
    );
  }
}
