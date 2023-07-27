import 'package:flutter/material.dart';
import 'package:habito/features/routines/widgets/home_appbar.dart';
import 'package:habito/features/routines/widgets/tasks_column.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<void> logOut() async {
    //   await context.read<UserProvider>().clearUserData();
    // }

    return Scaffold(
      appBar: const HomeAppBar(),
      // resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: logOut,
          //   child: const Text("Exit"),
          // ),
          Expanded(child: TasksColumn()),
          // const Spacer(),
        ],
      ),
    );
  }
}
