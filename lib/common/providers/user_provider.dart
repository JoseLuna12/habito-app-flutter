import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habito/common/database/shared_preferences.dart';
// import 'package:habito/features/authentication/services/user_local.dart';
// import 'package:shared_preferences/shared_preferences.dart';

enum UserLoadingStatus { loading, authenticated, unauthenticated, error }

class UserProvider extends ChangeNotifier {
  UserProvider({required this.preferences});
  late HabitoSharedPreferences preferences;

  final StreamController<UserLoadingStatus> _userGlobalEstatus =
      StreamController<UserLoadingStatus>.broadcast();
  bool _appInitialized = false;
  bool _logged = false;
  String? _userName;

  Stream<UserLoadingStatus> get userStatus => _userGlobalEstatus.stream;
  bool get logged => _logged;
  String? get user => _userName;
  bool get isAppInitialized => _appInitialized;

  void softLoginUser(String name) {
    _userGlobalEstatus.add(UserLoadingStatus.loading);
    preferences.saveUserNameSoft(name);
    _userGlobalEstatus.add(UserLoadingStatus.authenticated);
    _logged = true;
  }

  Future<void> softLogOutUser() async {
    _userGlobalEstatus.add(UserLoadingStatus.loading);
    await preferences.clearUserName();
    _logged = false;
    _userName = null;
    _userGlobalEstatus.add(UserLoadingStatus.unauthenticated);
  }

  String? softGetCurrentUser() {
    _userGlobalEstatus.add(UserLoadingStatus.loading);
    final user = preferences.getUserName();

    if (user == null) {
      _userGlobalEstatus.add(UserLoadingStatus.unauthenticated);
      return user;
    }
    _userGlobalEstatus.add(UserLoadingStatus.authenticated);
    _logged = true;
    _userName = user;
    return user;
  }

  void initApp() {
    final user = softGetCurrentUser();
    _appInitialized = true;
    _userName = user;
  }
}
