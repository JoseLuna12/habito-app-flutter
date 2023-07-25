import 'package:habito/features/authentication/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveStringToLocalStorage(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String> getStringFromLocalStorage(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

Future<User> saveUser(User user) async {
  Future.wait([
    saveStringToLocalStorage('id', user.id.toString()),
    saveStringToLocalStorage('email', user.email),
    saveStringToLocalStorage('name', user.name),
    saveStringToLocalStorage('token', user.jwToken)
  ]);
  return user;
}

Future<List<bool>> clearUser() async {
  final prefs = await SharedPreferences.getInstance();
  return Future.wait([
    prefs.remove('id'),
    prefs.remove('email'),
    prefs.remove('name'),
    prefs.remove('token'),
  ]);
}

Future<User?> getCurrentUser() async {
  final String id = await getStringFromLocalStorage('id');
  final String name = await getStringFromLocalStorage('name');
  final String email = await getStringFromLocalStorage('email');
  final String token = await getStringFromLocalStorage('token');

  if (token.isNotEmpty) {
    return User(id: int.parse(id), name: name, email: email, jwToken: token);
  }
  return null;
}
