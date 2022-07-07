// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_print
import 'package:flutter/material.dart';
import 'package:post_api_app/putApp/data_model_put.dart';
import 'package:http/http.dart' as http;

class PutPage extends StatefulWidget {
  const PutPage({Key? key}) : super(key: key);

  @override
  State<PutPage> createState() => _PutPageState();
}

Future<DataModelPut?> postData(String name, String job) async {
  final response = await http.put(Uri.parse("https://reqres.in/api/users/2"),
      body: {"name": name, "job": job});
  final data = response.body;
  // ignore: avoid_print
  print(data);
  if (response.statusCode == 200) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _dataModelPut = dataModelFromJson(data);

    return _dataModelPut;
  } else {
    return null;
  }
}

class _PutPageState extends State<PutPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  DataModelPut? _dataModelPut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: Colors.black12,
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Put Page",
                    style: TextStyle(
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Name ",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: "Enter Job Here"),
                    controller: jobController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _dataModelPut == null
                      ? Container()
                      : Text(
                          "The user: ${_dataModelPut!.name}, is updated successfully at time ${_dataModelPut!.updatedAt.toIso8601String()},\n Who's Job is : ${_dataModelPut!.job}",
                          style: TextStyle(color: Colors.black),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("data : ${_dataModelPut?.name}"),

                  ElevatedButton(
                      onPressed: () {
                        final String name = nameController.text;
                        final String job = jobController.text;

                        postData(name, job).then((val) {
                          print(val);
                          setState(() {
                            print('in Set state');
                            _dataModelPut = val;
                          });

                          // ignore: avoid_print
                          print(_dataModelPut?.job);
                        });
                        print(_dataModelPut!.job);
                      },
                      child: Text("Put")),

                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
