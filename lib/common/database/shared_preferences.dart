import 'package:shared_preferences/shared_preferences.dart';

class HabitoSharedPreferences {
  late SharedPreferences sharedPreferences;
  HabitoSharedPreferences({required this.sharedPreferences});

  String? getStringFromLocalStorage(String key) {
    return sharedPreferences.getString(key);
  }

  void saveStringToLocalStorage(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  void saveUserNameSoft(String name) {
    saveStringToLocalStorage('name', name);
  }

  Future<bool> clearUserName() async {
    return await sharedPreferences.remove('name');
  }

  String? getUserName() {
    return getStringFromLocalStorage('name');
  }
}
