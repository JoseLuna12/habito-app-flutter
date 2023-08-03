import 'package:flutter/material.dart';
import 'package:habito/common/database/isar.dart';
import 'package:habito/common/models/routine.isar.dart';
import 'package:habito/common/models/task.isar.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = List<Task>.empty(growable: true);
  Routine? _currentRoutine;
  List<Task> get tasks => _tasks;
  Routine? get currentRoutine => _currentRoutine;
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

  Future<void> initRoutineByDay(String time) async {
    final db = IsarDatabase();
    _currentRoutine = await db.getRoutineByTime(time: time);
    final tasksLinks = _currentRoutine?.tasks;
    final List<Task> currentTasks = [];
    if (tasksLinks != null) {
      for (var element in tasksLinks) {
        currentTasks.add(element);
      }
    }
    _tasks = currentTasks;
    notifyListeners();
  }

  Future<void> completeRoutineByDay(String time) async {
    final db = IsarDatabase();
    await db.updateRutineByDay(time, true);
    if (_currentRoutine != null) {
      _currentRoutine!.completed = true;
    }
    notifyListeners();
  }

  Future<void> uncompleteRoutineByDay(String time) async {
    final db = IsarDatabase();
    await db.updateRutineByDay(time, false);
    if (_currentRoutine != null) {
      _currentRoutine!.completed = false;
    }
    notifyListeners();
  }

  Future<void> saveRecommendation(
    String recommendation,
    IsarDatabase? database,
  ) async {
    final db = database ?? IsarDatabase();
    await db.saveRecom(recommendation);
  }

  Future<void> addTaskToRoutine(Task task) async {
    final db = IsarDatabase();
    await db.saveTaskToRoutine(task.time ?? "", task);
    await saveRecommendation(task.name, db);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final db = IsarDatabase();
    await db.saveTask(task);
    _tasks.add(task);
    await saveRecommendation(task.name, db);

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
      // print(err);
      return false;
    }
  }
}
