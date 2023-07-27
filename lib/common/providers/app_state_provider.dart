import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  FocusNode? _currentInputFocus;

  bool _isKeyboardOpen = false;

  bool get isKeyboardOpen => _isKeyboardOpen;

  void closeKeyboard() {
    if (_currentInputFocus == null) {
      return;
    }
    _currentInputFocus?.unfocus();
    _isKeyboardOpen = false;
    _currentInputFocus = null;
    notifyListeners();
  }

  void openKeyboard(FocusNode inputNode) {
    _currentInputFocus = inputNode;
    inputNode.requestFocus();
    _isKeyboardOpen = true;
    notifyListeners();
  }
}
