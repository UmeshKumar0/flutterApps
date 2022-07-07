// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_print
import 'package:flutter/material.dart';
import 'package:post_api_app/postApp/data_model_post.dart';
import 'package:http/http.dart' as http;

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _MyWidgetState();
}

Future<DataModel?> postData(String name, String job) async {
  final response = await http.post(Uri.parse("https://reqres.in/api/users"),
      body: {"name": name, "job": job});
  final data = response.body;
  // ignore: avoid_print
  print(data);
  if (response.statusCode == 201) {
    final dataModel = dataModelFromJson(data);

    return dataModel;
  } else {
    return null;
  }
}

class _MyWidgetState extends State<HomeWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  DataModel? dataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        color: Colors.black12,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ignore: prefer_const_constructors
              Text(
                "Post Page",
                style: TextStyle(
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Name ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Enter Name Here"),
                controller: nameController,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Job ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Enter Job Here"),
                controller: jobController,
              ),
              SizedBox(
                height: 30,
              ),
              dataModel == null
                  ? Container()
                  : Text(
                      "The user: ${dataModel!.name},\nWith id : ${dataModel!.id}\n is created successfully at time ${dataModel!.createdAt.toIso8601String()},\n Who's Job is : ${dataModel!.job}",
                      style: TextStyle(color: Colors.black),
                    ),
              SizedBox(
                height: 30,
              ),
              Text("data : ${dataModel?.name}"),

              ElevatedButton(
                  onPressed: () {
                    final String name = nameController.text;
                    final String job = jobController.text;

                    postData(name, job).then((val) {
                      print(val);
                      setState(() {
                        print('in Set state');
                        dataModel = val;
                      });

                      // ignore: avoid_print
                      print(dataModel?.job);
                    });
                    print(dataModel!.job);
                  },
                  child: Text("Post")),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
