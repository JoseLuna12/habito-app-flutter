import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  FocusNode? _currentInputFocus;

  bool _isKeyboardOpen = false;

  bool get isKeyboardOpen => _isKeyboardOpen;

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
    notifyListeners();
  }

  void openKeyboard(FocusNode inputNode) {
    _currentInputFocus = inputNode;
    _isKeyboardOpen = true;
    inputNode.requestFocus();
    notifyListeners();
  }
}
