import 'package:flutter/material.dart';
import 'package:habito/common/providers/app_state_provider.dart';
import 'package:habito/constants/app_colors.dart';

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
  // final listScrollController = ScrollController();

  final taskInputController = TextEditingController();
  final inputFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    void newTask(String task) {
      if (task.isEmpty) {
        return;
      }
      final t = Task()
        ..name = task
        ..time = "26:07:2023";
      context.read<TaskProvider>().addTask(t);
      taskInputController.clear();
    }

    void newTaskAction() {
      context.read<AppStateProvider>().openKeyboard(inputFocusNode);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: HabiMeasurements.paddingHorizontalButtonXl,
            right: HabiMeasurements.paddingHorizontalButtonXl,
            bottom: 30,
          ),
          child: ElevatedButton(
            onPressed: context.watch<AppStateProvider>().isKeyboardOpen
                ? null
                : newTaskAction,
            child: const Text("new task"),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: context.read<TaskProvider>().initTasks(),
            builder: (context, snapshot) {
              List<Task> tasks =
                  context.watch<TaskProvider>().tasks.reversed.toList();
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: HabiMeasurements.paddingHorizontal,
                ),
                child: ListView.builder(
                  // controller: listScrollController,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListTile(task: tasks[index]);
                  },
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: context.watch<AppStateProvider>().isKeyboardOpen,
          child: TextField(
            controller: taskInputController,
            focusNode: inputFocusNode,
            // onChanged: (_) => updateErrorLabel(""),
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
            onSubmitted: (value) => newTask(value),
            onEditingComplete: () {
              if (taskInputController.text.isEmpty) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
          ),
        )
      ],
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
                child: Text("Delete"),
              )
            ],
          ),
        ),
        // secondaryBackground: const ListTile(),
        child: ListTile(
          title: Text(widget.task.name),
        ),
      ),
    );
  }
}
