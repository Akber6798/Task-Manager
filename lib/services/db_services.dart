// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const TASK_DB_NAME = 'task_database';

class DataBaseServices {
  static DataBaseServices instance = DataBaseServices();

  //add task to data base
  Future<void> addTask(TaskModel task) async {
    final taskManagerBox = await Hive.openBox<TaskModel>(TASK_DB_NAME);
    taskManagerBox.put(task.id, task);
  }

  //get tasks from database as list of datas
  Future<List<TaskModel>> getTasks() async {
    final taskManagerBox = await Hive.openBox<TaskModel>(TASK_DB_NAME);
    return taskManagerBox.values.toList();
  }

  //delete single task from database
  Future<void> deleteTask(String id) async {
    final taskManagerBox = await Hive.openBox<TaskModel>(TASK_DB_NAME);
    taskManagerBox.delete(id);
  }

  //delete all tasks from database and also delete name
  Future<void> deleteAllData() async {
    final taskManagerBox = await Hive.openBox<TaskModel>(TASK_DB_NAME);
    taskManagerBox.clear();
    SharedPreferences prefference = await SharedPreferences.getInstance();
    prefference.remove('name');
  }
}
