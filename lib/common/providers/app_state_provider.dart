import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habito/common/database/isar.dart';
import 'package:habito/common/models/task_recommendation.isar.dart';

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
    notifyListeners();
  }
}
