import 'package:flutter/material.dart';
import 'package:habito/common/providers/task_provider.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:habito/features/routines/widgets/bottom_bar.dart';
// import 'package:habito/common/providers/user_provider.dart';
import 'package:habito/features/routines/widgets/day_selector.dart';
import 'package:habito/features/routines/widgets/home_appbar.dart';
import 'package:habito/features/routines/widgets/tasks_column.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // void logOut() {
    //   context.read<UserProvider>().softLogOutUser();
    // }
    final selectedDay = context.watch<WeekProvider>().weeksValues.activeDay;

    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      appBar: const HomeAppBar(),
      // resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: context
            .read<TaskProvider>()
            .initRoutineStreamByDay(selectedDay.keyDate),
        builder: (context, snapshot) {
          return const Column(
            children: [
              // ElevatedButton(
              //   onPressed: logOut,
              //   child: const Text("Exit"),
              // ),
              DaySelector(),
              Expanded(child: TasksColumn()),
            ],
          );
        },
      ),
    );
  }
}
