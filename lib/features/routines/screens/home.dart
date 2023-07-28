import 'package:flutter/material.dart';
import 'package:habito/common/date/week.dart';
import 'package:habito/common/providers/user_provider.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:habito/features/routines/widgets/day_selector.dart';
import 'package:habito/features/routines/widgets/home_appbar.dart';
import 'package:habito/features/routines/widgets/tasks_column.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut() {
      context.read<UserProvider>().softLogOutUser();
    }

    return const Scaffold(
      appBar: HomeAppBar(),
      // resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // ElevatedButton(
          //   onPressed: logOut,
          //   child: const Text("Exit"),
          // ),
          DaySelector(),
          Expanded(child: TasksColumn()),
          // const Spacer(),
        ],
      ),
    );
  }
}
