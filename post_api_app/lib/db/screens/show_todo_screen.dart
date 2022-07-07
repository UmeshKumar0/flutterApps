// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_api_app/db/provider/todo_provider.dart';
import 'package:post_api_app/db/screens/add_todo_screen.dart';
import 'package:provider/provider.dart';

import 'edit_todo_screen.dart';

class ShowToDoScreen extends StatelessWidget {
  const ShowToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddToDoScreen()))
              },
          child: Icon(CupertinoIcons.arrow_up_right_diamond)),
      appBar: AppBar(
        title: Text("To Do"),
      ),
      body: FutureBuilder(
        future: Provider.of<TodoProvider>(context, listen: false).selectData(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return Consumer<TodoProvider>(
              builder: (context, todoprovider, child) {
                return todoprovider.todoItem.isNotEmpty
                    ? ListView.builder(
                        itemCount: todoprovider.todoItem.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(todoprovider.todoItem[index].id),
                            background: Container(
                              margin: EdgeInsets.all(width * 0.01),
                              padding: EdgeInsets.all(width * 0.03),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.03)),
                              alignment: Alignment.centerLeft,
                              width: width,
                              height: height * 0.2,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            secondaryBackground: Container(
                              padding: EdgeInsets.all(width * 0.03),
                              margin: EdgeInsets.all(width * 0.02),
                              width: width,
                              height: height * 0.02,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.03)),
                              alignment: Alignment.centerRight,
                              child: Icon(
                                CupertinoIcons.delete_simple,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                return Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => EditToDoScreen(
                                              id: todoprovider
                                                  .todoItem[index].id,
                                              title: todoprovider
                                                  .todoItem[index].title,
                                              description: todoprovider
                                                  .todoItem[index].description,
                                              date: todoprovider
                                                  .todoItem[index].date,
                                            )));
                              } else {
                                showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          scrollable: true,
                                          title: Text("Delete"),
                                          content:
                                              Text("Do you want to delete it?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  todoprovider.deleteById(
                                                    todoprovider
                                                        .todoItem[index].id,
                                                  );
                                                  todoprovider.todoItem.remove(
                                                    todoprovider
                                                        .todoItem[index],
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Yes")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("No")),
                                          ],
                                        ));
                              }
                            },
                            child: Card(
                              elevation: 9,
                              child: ListTile(
                                style: ListTileStyle.drawer,
                                title: Text(todoprovider.todoItem[index].title),
                                subtitle: Text(
                                    todoprovider.todoItem[index].description),
                                trailing:
                                    Text(todoprovider.todoItem[index].date),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "List is empty",
                          style: TextStyle(color: Colors.black, fontSize: 35),
                        ),
                      );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
