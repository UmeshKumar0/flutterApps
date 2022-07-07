// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({Key? key}) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      print('$e');
    }
  }

  Future clickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    clickImage();
                  },
                  icon: Icon(Icons.camera_alt_outlined)),
              SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () {
                    pickImage();
                  },
                  icon: Icon(Icons.insert_drive_file_outlined)),
            ],
          )
        ],
        title: Text("My App"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 80),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Download and \nOpen any File",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.purple[900],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                image != null
                    ? Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                    : Container(),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      shadowColor: Colors.red,
                      elevation: 5,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    icon: Icon(Icons.video_call_sharp),
                    onPressed: () => openFile(
                        url:
                            "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
                        fileName: "video.mp4"),
                    label: Text(
                      "Download and open",
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    padding: EdgeInsets.all(20),
                    onPrimary: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 5,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  icon: Icon(Icons.file_open_rounded),
                  onPressed: () => openFile(
                      url:
                          "https://www.clickdimensions.com/links/TestPDFfile.pdf",
                      fileName: "Sample.pdf"),
                  label: Text(
                    "Download and open",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    padding: EdgeInsets.all(20),
                    onPrimary: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 5,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  icon: Icon(Icons.image_search),
                  onPressed: () => openFile(
                      url:
                          "https://2.img-dpreview.com/files/p/E~C1000x0S4000x4000T1200x1200~articles/3925134721/0266554465.jpeg",
                      fileName: "Sample.jpeg"),
                  label: Text(
                    "Download and open",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.bottomRight,
                    primary: Colors.teal,
                    padding: EdgeInsets.all(20),
                    onPrimary: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 5,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  icon: Icon(Icons.folder),
                  onPressed: () => openFilePick(url: '/UmeshApp'),
                  label: Text(
                    "Open ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future openFilePick({required String url, String? fileName}) async {
    final name = fileName ?? url.split("/").last;
    final file = await pickFile();
    if (file == null) return;

    print("Path: ${file.path}");
    OpenFile.open(file.path);
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    // final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return File(result.files.first.path!);
  }

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;

    print("Path: ${file.path}");
    OpenFile.open(file.path);
    print(file.path);
  }

  //Download file into private storage which is not visible to user
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      print("Download Fail");
      return null;
    }
  }
}
