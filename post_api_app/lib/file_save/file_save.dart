// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings, avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;
  Directory? _directory;

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/UmeshApp";
          directory = Directory(newPath);
          _directory = directory;
          print(directory);
          print(_directory.toString());
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile() async {
    setState(() {
      loading = false;
      progress = 0;
    });
    bool downloaded = await saveVideo(
        "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
        "video.mp4");
    if (downloaded) {
      print("File Downloaded");

      final snackBar = SnackBar(
        content: const Text('File Downloaded ,Successfully!!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Center(
            child: loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: progress,
                    ),
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton.icon(
                          icon: Icon(
                            Icons.download_rounded,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                          onPressed: downloadFile,
                          padding: const EdgeInsets.all(10),
                          label: Text(
                            "Download Video",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      FlatButton.icon(
                          icon: Icon(
                            Icons.video_call_outlined,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            String newpath =
                                '/storage/emulated/0/UmeshApp/video.mp4';
                            print(newpath.toString());
                            OpenFile.open(newpath);
                          },
                          padding: const EdgeInsets.all(10),
                          label: Text(
                            "View",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
