import 'package:flutter/material.dart';
import 'package:habito/features/authentication/services/user_local.dart';

// enum UserLoadingStatus { loading, loaded, none }

class UserProvider extends ChangeNotifier {
  String? _user;
  // UserLoadingStatus status = UserLoadingStatus.none;

  String? get user => _user;

  bool get userExists => _user != null;

  Future<String?> initUser() async {
    _user ??= await getUser();

    return _user;
  }

  Future<void> setUser(String user) async {
    await saveUserSoft(user);
    _user = await getUser();
    notifyListeners();
  }

  Future<String?> getUser() async {
    final userName = await getCurrentUserName();
    // print(userName);
    // notifyListeners();
    return userName;
  }

  Future<bool> clearUserData() async {
    final res = await clearUserName();
    _user = null;
    notifyListeners();
    return res;
  }
}
