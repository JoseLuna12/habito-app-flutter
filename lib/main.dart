import 'package:flutter/material.dart';
import 'package:habito/common/providers/task_provider.dart';
import 'package:habito/common/providers/user_provider.dart';
import 'package:habito/common/widgets/loading_placeholder.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/features/authentication/screens/sign_in.dart';
import 'package:habito/features/authentication/screens/soft_authentication.dart';
import 'package:habito/features/routines/screens/home.dart';
import 'package:habito/themes/classic.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habito.',
      theme: HabiTheme.lightTheme,
      darkTheme: HabiTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: FutureBuilder<String?>(
        future: context.read<UserProvider>().initUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (context.watch<UserProvider>().user == null) {
              return const SoftSignIn();
            }
            return HomeScreen();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPlaceholder();
          }

          if (snapshot.hasError) {
            return const Placeholder();
          }

          return const LoadingPlaceholder();
        },
      ),
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
