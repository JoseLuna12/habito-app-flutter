import 'package:flutter/material.dart';
import 'package:habito/features/authentication/screens/sign_in.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/themes/classic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: HabiTheme.lightTheme,
      darkTheme: HabiTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SignIn(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 130,
        leading: const Center(
          child: Text(
            "Hola peter",
            style: TextStyle(fontSize: 26),
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundColor: HabiColor.orange,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView(
              children: const [
                ListTile(
                  title: Text("this is a test"),
                ),
                ListTile(
                  title: Text("this is a test"),
                ),
                ListTile(
                  title: Text("this is a test"),
                ),
                ListTile(
                  title: Text("this is a test"),
                ),
                ListTile(
                  title: Text("this is a test"),
                ),
              ],
            )),
            const TextField(
              decoration: InputDecoration(hintText: "email"),
            ),
            TextButton(onPressed: () {}, child: const Text("this is test")),
            ElevatedButton(
              onPressed: () {},
              child: const Text("data"),
            )
          ],
        ),
      ),
    );
  }
}
