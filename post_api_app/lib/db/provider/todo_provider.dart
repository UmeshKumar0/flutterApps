// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:post_api_app/db/database_helper.dart';
import 'package:post_api_app/db/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> todoItem = [];

  Future<void> selectData() async {
    final dataList = await DBHelper.selectAll(DBHelper.todo);
    todoItem = dataList
        .map(
          (item) => TodoModel(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            date: item['date'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future insertData(String title, String description, String date) async {
    final newToDo = TodoModel(
        id: const Uuid().v1(),
        title: title,
        description: description,
        date: date);
    todoItem.add(newToDo);
    DBHelper.insert(
      DBHelper.todo,
      {
        'id': newToDo.id,
        'title': newToDo.title,
        'description': newToDo.description,
        'date': newToDo.date,
      },
    );
    notifyListeners();
  }

  Future updateTitle(String id, String title) async {
    DBHelper.update(
      DBHelper.todo,
      'title',
      title,
      id,
    );
    notifyListeners();
  }

  Future updateDescription(String id, String description) async {
    DBHelper.update(
      DBHelper.todo,
      'description',
      description,
      id,
    );
    notifyListeners();
  }

  Future updateDate(String id, String date) async {
    DBHelper.update(
      DBHelper.todo,
      'date',
      date,
      id,
    );
    notifyListeners();
  }

  Future deleteById(id) async {
    DBHelper.deleteById(
      DBHelper.todo,
      'id',
      id,
    );
    notifyListeners();
  }
}
