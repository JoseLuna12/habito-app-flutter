import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habito/common/date/day.dart';
import 'package:habito/common/providers/app_state_provider.dart';
import 'package:habito/common/providers/task_provider.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<AppStateProvider>().isDarkMode(context);
    final routine = context.watch<TaskProvider>().currentRoutine;

    final weekProvider = context.watch<WeekProvider>();
    final today = weekProvider.weeksValues.today;
    final activeDay = weekProvider.weeksValues.activeDay;

    final yesterdayDate = today.date.subtract(const Duration(days: 1));
    final isFutureDate = today.date.isBefore(activeDay.date);
    final isPastDate = today.date.isAfter(activeDay.date);
    final yesterday = HabiDay(date: yesterdayDate);

    bool canComplete = false;

    if (today.keyDate == activeDay.keyDate) {
      canComplete = true;
    }

    if (activeDay.keyDate == yesterday.keyDate) {
      canComplete = true;
    }

    return Visibility(
      visible: canComplete && routine != null && !routine.completed,
      replacement: CompleteRoutineBadge(
        completed: routine != null && routine.completed,
        isPast: isPastDate,
        isFuture: isFutureDate,
      ),
      child: Container(
        color: isDarkMode ? HabiColor.blue : HabiColor.white,
        height: 80,
        child: const Bar(),
      ),
    );
  }
}

class CompleteRoutineBadge extends StatelessWidget {
  const CompleteRoutineBadge(
      {super.key,
      required this.completed,
      required this.isFuture,
      required this.isPast});

  final bool completed;
  final bool isFuture;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    Color badgeColor = completed ? Colors.green : HabiColor.dangerLight;

    if (isFuture) {
      badgeColor = HabiColor.grayDark;
    }

    if (isPast && !completed) {
      badgeColor = HabiColor.grayDark;
    }

    final String text = completed ? "Completed" : "Incompleted";
    final IconData icon = completed
        ? Icons.check_circle_outline_outlined
        : Icons.dangerous_outlined;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: HabiMeasurements.paddingBottomLast - 10,
        left: HabiMeasurements.paddingHorizontalButtonXl,
        right: HabiMeasurements.paddingHorizontalButtonXl,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: BorderRadius.circular(HabiMeasurements.cornerRadius),
        ),
        width: 250,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: HabiColor.white),
            ),
            const SizedBox(
              width: 10,
            ),
            Visibility(
              visible: !isFuture,
              child: Icon(
                icon,
                color: HabiColor.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Bar extends StatefulWidget {
  const Bar({super.key});

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> with SingleTickerProviderStateMixin {
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonAnimation;
  late HabiDay selectedDay;
  final int secondsToStop = 3;
  int timeElapsed = 0;
  bool buttonPressed = false;

  @override
  void initState() {
    super.initState();
    selectedDay = context.read<WeekProvider>().weeksValues.activeDay;

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener(completeRoutine);

    _buttonAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_buttonAnimationController);
  }

  void completeRoutine(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      HapticFeedback.heavyImpact();
      context.read<TaskProvider>().completeRoutineByDay(selectedDay.keyDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = context.watch<TaskProvider>().isTaskEmpty;
    final isDarkMode = context.read<AppStateProvider>().isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTapDown: isEmpty
              ? null
              : (details) {
                  HapticFeedback.selectionClick();
                  buttonPressed = true;
                  _buttonAnimationController.forward();
                },
          onTapUp: isEmpty
              ? null
              : (details) {
                  HapticFeedback.lightImpact();
                  buttonPressed = false;
                  _buttonAnimationController.reset();
                },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(HabiMeasurements.cornerRadius),
            ),
            child: AnimatedBuilder(
              animation: _buttonAnimationController,
              builder: (context, child) {
                double animatedValue = _buttonAnimation.value;
                return Container(
                  width: 250,
                  decoration: BoxDecoration(
                      color:
                          isDarkMode ? HabiColor.orange : HabiColor.blueLight,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8), // Shadow color
                          spreadRadius:
                              6, // Negative value to create inner shadow
                          blurRadius: 6,
                          offset: const Offset(
                              0, 6), // Offset to control the shadow position
                        ),
                      ]),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        color: isDarkMode
                            ? HabiColor.orangeLight
                            : HabiColor.blueDark,
                        width: (animatedValue * 250).roundToDouble(),
                        height: 50,
                      ),
                      Center(
                        child: Text(
                          isEmpty ? "Please add a task" : "Complete Routine",
                          style: const TextStyle(color: HabiColor.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
