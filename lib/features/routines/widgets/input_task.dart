import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habito/common/date/day.dart';
import 'package:habito/common/models/task.isar.dart';
import 'package:habito/common/providers/app_state_provider.dart';
import 'package:habito/common/providers/task_provider.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:provider/provider.dart';

class InputTask extends StatefulWidget {
  const InputTask({super.key});

  @override
  State<InputTask> createState() => _InputTaskState();
}

class _InputTaskState extends State<InputTask> {
  late final TextEditingController _taskInputController;
  late final FocusNode _inputFocusNode;

  late final TextEditingController _noteInputController;

  @override
  void initState() {
    _taskInputController = TextEditingController();
    _inputFocusNode = FocusNode();
    _noteInputController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputVisibility = context.watch<AppStateProvider>().isKeyboardOpen;
    final isDarkMode = context.watch<AppStateProvider>().isDarkMode(context);
    final HabiDay selectedDay =
        context.watch<WeekProvider>().weeksValues.activeDay;
    void newTask() {
      final String task = _taskInputController.text;
      if (task.isEmpty) {
        if (inputVisibility) {
          context.read<AppStateProvider>().closeKeyboard();
        }
        return;
      }
      final t = Task()
        ..name = task
        ..time = selectedDay.keyDate
        ..note = _noteInputController.text;
      context.read<AppStateProvider>().resetRecommendations();
      context.read<TaskProvider>().addTaskToRoutine(t);
      _taskInputController.clear();
      _noteInputController.clear();
      HapticFeedback.selectionClick();
    }

    Future<void> recommendationAction(String value) async {
      context.read<AppStateProvider>().updateCurrentInputValue(value);
      await context.read<AppStateProvider>().updateRecommendations();
    }

    if (inputVisibility) {
      _inputFocusNode.requestFocus();
    }

    return Visibility(
      visible: inputVisibility,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(HabiMeasurements.cornerRadius),
            topRight: Radius.circular(
              HabiMeasurements.cornerRadius,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: HabiColor.grayDark.withOpacity(0.3), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 10, // Blur radius
              offset: const Offset(0, 0), // Offset from the widget
            ),
          ],
          color: isDarkMode ? HabiColor.blueDark : HabiColor.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(HabiMeasurements.cornerRadius),
                  topRight: Radius.circular(
                    HabiMeasurements.cornerRadius,
                  ),
                ),
              ),
              height: 40,
              child: TextField(
                controller: _taskInputController,
                focusNode: _inputFocusNode,
                decoration: inputDecoration(
                    hintText: "Add task",
                    hintTextSize: 16,
                    hintTextBold: true,
                    isDarkMode: isDarkMode),
                // onChanged: (_) => updateErrorLabel(""),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => newTask(),
                onChanged: (value) => recommendationAction(value),
                onEditingComplete: () {
                  if (_taskInputController.text.isEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
              ),
            ),
            SizedBox(
              height: 35,
              child: TextField(
                controller: _noteInputController,
                // focusNode: _inputFocusNode,
                decoration: inputDecoration(
                    hintText: "Note", hintTextSize: 14, isDarkMode: isDarkMode),
                style: const TextStyle(
                  height: 1,
                  fontSize: 14,
                ),
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => newTask(),
                onEditingComplete: () {
                  if (_taskInputController.text.isEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: HabiMeasurements.paddingHorizontal),
              child: Text(
                "Suggestions",
                style: TextStyle(
                  height: 1,
                  fontSize: 14,
                  color: HabiColor.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RecommendationList(taskInputController: _taskInputController)
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration({
    required bool isDarkMode,
    required String hintText,
    required double hintTextSize,
    bool hintTextBold = false,
  }) {
    return InputDecoration(
      fillColor: isDarkMode ? HabiColor.blueDark : HabiColor.white,
      hintText: hintText,
      hintStyle: TextStyle(
        color: HabiColor.grayDark,
        fontWeight: hintTextBold ? FontWeight.bold : FontWeight.normal,
        fontSize: hintTextSize,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: HabiMeasurements.paddingHorizontal,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 0,
        ),
        gapPadding: 0,
        borderRadius: BorderRadius.vertical(
          top: Radius.zero,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0,
          color: isDarkMode ? HabiColor.blueDark : HabiColor.white,
        ),
        gapPadding: 0,
        borderRadius: BorderRadius.zero,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0,
          color: isDarkMode ? HabiColor.blueDark : HabiColor.white,
        ),
        gapPadding: 0,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(HabiMeasurements.cornerRadius),
        ),
      ),
    );
  }
}

class RecommendationList extends StatelessWidget {
  const RecommendationList({
    super.key,
    required TextEditingController taskInputController,
  }) : _taskInputController = taskInputController;

  final TextEditingController _taskInputController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HabiMeasurements.paddingHorizontal,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: StreamBuilder(
              stream: context.watch<AppStateProvider>().recommendationsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final textValue = snapshot.data![index].name;
                      return TextButton(
                        onPressed: () {
                          _taskInputController.text = textValue;
                          _taskInputController.selection =
                              TextSelection.fromPosition(
                            TextPosition(offset: textValue.length),
                          );
                        },
                        child: Text(
                          textValue,
                          style: const TextStyle(
                            height: 1,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ))
          ],
        ),
      ),
    );
  }
}
