import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habito/common/database/isar.dart';
import 'package:habito/common/models/task_recommendation.isar.dart';
import 'package:habito/common/providers/task_provider.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:provider/provider.dart';

class AppStateProvider extends ChangeNotifier {
  FocusNode? _currentInputFocus;
  bool _isKeyboardOpen = false;
  String? _currentInputValue;
  List<Recommendation> _recommendations =
      List<Recommendation>.empty(growable: true);

  final StreamController<List<Recommendation>> _recommendationsStream =
      StreamController.broadcast();

  bool get isKeyboardOpen => _isKeyboardOpen;

  List<Recommendation> get recommendations => _recommendations;

  Stream<List<Recommendation>> get recommendationsStream =>
      _recommendationsStream.stream;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  void closeKeyboard() {
    if (_currentInputFocus == null) {
      return;
    }
    _currentInputFocus?.unfocus();
    _isKeyboardOpen = false;
    _currentInputFocus = null;
    _currentInputValue = null;
    resetRecommendations();
    // _recommendationsStream.close();
    notifyListeners();
  }

  void resetRecommendations() {
    _recommendationsStream.add([]);
  }

  void updateCurrentInputValue(String value) {
    _currentInputValue = value;
    notifyListeners();
  }

  Future<void> updateRecommendations() async {
    if (_currentInputValue == null) {
      return;
    }
    final db = IsarDatabase();
    _recommendations = await db.getRecommendationsFrom(_currentInputValue!);
    _recommendationsStream.add(_recommendations);
  }

  void openKeyboard(FocusNode inputNode) {
    _currentInputFocus = inputNode;
    _isKeyboardOpen = true;
    inputNode.requestFocus();
    print("object");
    notifyListeners();
  }

  bool canCompleteRoutine(BuildContext context) {
    final taskProvider = context.read<TaskProvider>();
    final weekProvider = context.read<WeekProvider>();
    final today = weekProvider.weeksValues.today;
    final activeDay = weekProvider.weeksValues.activeDay;

    final tomorrow = today.date..add(const Duration(days: 1));
    final yesterday = today.date..subtract(const Duration(days: 1));

    bool canComplete = true;

    if (today.keyDate == activeDay.keyDate) {
      print("is today");
      canComplete = false;
    }

    if (activeDay.date == yesterday) {
      print("is yesterday");
      canComplete = false;
    }

    if (taskProvider.tasks.isNotEmpty) {
      print("is not empty");
      canComplete = false;
    }

    return canComplete;
  }
}
