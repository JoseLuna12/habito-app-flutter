import 'package:flutter/material.dart';
import 'package:habito/common/database/isar.dart';
import 'package:habito/common/models/task.isar.dart';
// import 'package:habito/features/authentication/services/user_local.dart';

// enum UserLoadingStatus { loading, loaded, none }

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = List<Task>.empty(growable: true);

  List<Task> get tasks => _tasks;

  Future<void> initTasks() async {
    final db = IsarDatabase();
    _tasks = await db.getTasks();
    notifyListeners();
  }

  Future<void> initTaskByDay(String time) async {
    final db = IsarDatabase();
    _tasks = await db.getTasksByDay(time);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final db = IsarDatabase();
    await db.saveTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<bool> removeTask(Task task) async {
    final db = IsarDatabase();
    try {
      await db.deleteTask(task.localId);
      _tasks = _tasks.where((t) => t.localId != task.localId).toList();
      notifyListeners();
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
