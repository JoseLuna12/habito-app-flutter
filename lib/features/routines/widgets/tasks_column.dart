import 'package:flutter/material.dart';
import 'package:habito/common/date/day.dart';
import 'package:habito/common/providers/app_state_provider.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/features/routines/widgets/input_task.dart';

import 'package:provider/provider.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/common/models/task.isar.dart';
import 'package:habito/common/providers/task_provider.dart';

class TasksColumn extends StatefulWidget {
  const TasksColumn({
    super.key,
  });

  @override
  State<TasksColumn> createState() => _TasksColumnState();
}

class _TasksColumnState extends State<TasksColumn> {
  final taskInputController = TextEditingController();
  final inputFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        context.watch<AppStateProvider>().isDarkMode(context);
    final buttonBackgroundColor = isDarkMode ? HabiColor.blue : HabiColor.white;
    final selectedDay = context.watch<WeekProvider>().weeksValues.activeDay;
    List<Task> tasks = context.watch<TaskProvider>().tasks.reversed.toList();

    if (tasks.isEmpty) {
      context.read<TaskProvider>().uncompleteRoutineByDay(selectedDay.keyDate);
    }

    void newTaskAction() {
      context.read<AppStateProvider>().openKeyboard(inputFocusNode);
    }

    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: context
                .read<TaskProvider>()
                .initRoutineByDay(selectedDay.keyDate),
            builder: (context, snapshot) {
              if (tasks.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: HabiMeasurements.paddingHorizontal,
                  ),
                  child: Column(
                    children: [
                      AddTasksButton(
                          buttonBackgroundColor: buttonBackgroundColor,
                          newTaskAction: newTaskAction),
                      Expanded(
                        child: Visibility(
                          visible:
                              !context.watch<AppStateProvider>().isKeyboardOpen,
                          child: const Center(
                            child: Text("No tasks for today 🥲"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: HabiMeasurements.paddingHorizontal,
                ),
                child: ListView.builder(
                  // controller: listScrollController,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return AddTasksButton(
                          buttonBackgroundColor: buttonBackgroundColor,
                          newTaskAction: newTaskAction);
                    }
                    return TaskListTile(task: tasks[index - 1]);
                  },
                ),
              );
            },
          ),
        ),
        const InputTask()
      ],
    );
  }
}

class AddTasksButton extends StatefulWidget {
  const AddTasksButton({
    super.key,
    required this.buttonBackgroundColor,
    required this.newTaskAction,
  });

  final Color buttonBackgroundColor;
  final void Function() newTaskAction;

  @override
  State<AddTasksButton> createState() => _AddTasksButtonState();
}

class _AddTasksButtonState extends State<AddTasksButton> {
  @override
  Widget build(BuildContext context) {
    // final isKeyboardOpen = context.watch<AppStateProvider>().isKeyboardOpen;
    final weekProvider = context.watch<WeekProvider>();
    final today = weekProvider.weeksValues.today;
    final activeDay = weekProvider.weeksValues.activeDay;

    final tomorrowDate = today.date.add(const Duration(days: 1));
    final tomorrow = HabiDay(date: tomorrowDate);

    final isToday = activeDay.keyDate == today.keyDate;
    final isTomorrow = tomorrow.keyDate == activeDay.keyDate;

    bool canAddTask = false;

    if (isToday) {
      canAddTask = true;
    }

    if (isTomorrow) {
      canAddTask = true;
    }

    // if (isKeyboardOpen == false) {
    //   canAddTask = true;
    // }
    // print(isTomorrow);

    return Container(
      padding: const EdgeInsets.only(
        top: 25,
        left: HabiMeasurements.paddingHorizontalButtonXl,
        right: HabiMeasurements.paddingHorizontalButtonXl,
        bottom: 30,
      ),
      color: widget.buttonBackgroundColor,
      child: ElevatedButton(
        onPressed: canAddTask ? widget.newTaskAction : null,
        child: const Text("new task"),
      ),
    );
  }
}

class TaskListTile extends StatefulWidget {
  const TaskListTile({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    Future<bool> deleteTask(Task task) async {
      final complete = await context.read<TaskProvider>().removeTask(task);
      return complete;
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: HabiMeasurements.bottomTaskTilePadding,
      ),
      child: Dismissible(
        onDismissed: (direction) {
          deleteTask(widget.task);
        },
        // confirmDismiss: (direction) => deleteTask(widget.task),
        key: ValueKey(widget.task.localId),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: HabiColor.dangerLight,
            borderRadius: BorderRadius.circular(
              HabiMeasurements.cornerRadius,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  "Delete",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HabiColor.white,
                  ),
                ),
              )
            ],
          ),
        ),
        // secondaryBackground: const ListTile(),
        child: ListTile(
          title: Text(widget.task.name),
          subtitle: widget.task.note == null || widget.task.note == ""
              ? null
              : Text(widget.task.note ?? ""),
        ),
      ),
    );
  }
}
