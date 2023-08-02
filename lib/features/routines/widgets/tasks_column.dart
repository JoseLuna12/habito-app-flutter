import 'package:flutter/material.dart';
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

    void newTaskAction() {
      context.read<AppStateProvider>().openKeyboard(inputFocusNode);
    }

    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: context
                .watch<TaskProvider>()
                .initRoutineByDay(selectedDay.keyDate),
            builder: (context, snapshot) {
              List<Task> tasks =
                  context.read<TaskProvider>().tasks.reversed.toList();

              if (tasks.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: HabiMeasurements.paddingHorizontal,
                  ),
                  child: Column(
                    children: [
                      addTaskButton(
                        buttonBackgroundColor,
                        context,
                        newTaskAction,
                      ),
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
                      return addTaskButton(
                        buttonBackgroundColor,
                        context,
                        newTaskAction,
                      );
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

  Container addTaskButton(
    Color buttonBackgroundColor,
    BuildContext context,
    void Function() newTaskAction,
  ) {
    return Container(
      padding: const EdgeInsets.only(
        top: 25,
        left: HabiMeasurements.paddingHorizontalButtonXl,
        right: HabiMeasurements.paddingHorizontalButtonXl,
        bottom: 30,
      ),
      color: buttonBackgroundColor,
      child: ElevatedButton(
        onPressed: context.watch<AppStateProvider>().isKeyboardOpen
            ? null
            : newTaskAction,
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
