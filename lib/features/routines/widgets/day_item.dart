import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habito/common/date/day.dart';
import 'package:habito/common/providers/app_state_provider.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:provider/provider.dart';

class DayListItem extends StatelessWidget {
  const DayListItem({super.key, required this.currDay});

  final HabiDay currDay;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        context.watch<AppStateProvider>().isDarkMode(context);

    Color dayNameColor = isDarkMode ? HabiColor.gray : HabiColor.gray;
    Color dayNumberColor = isDarkMode ? HabiColor.white : HabiColor.blue;
    Color dotColor = HabiColor.orange;
    BoxDecoration boxDecoration = currDay.isActive
        ? BoxDecoration(
            border: Border.all(color: HabiColor.orange, width: 1),
            borderRadius: BorderRadius.circular(HabiMeasurements.cornerRadius),
          )
        : BoxDecoration(
            border: Border.all(
              color: isDarkMode ? HabiColor.blue : HabiColor.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(HabiMeasurements.cornerRadius),
          );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
        context.read<WeekProvider>().selectDay(currDay);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: 50,
        decoration: boxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currDay.weekDayShort,
              style: TextStyle(
                height: 1,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: dayNameColor,
              ),
            ),
            Text(
              "${currDay.dayOfTheMonth}",
              style: TextStyle(
                  height: 1.2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: dayNumberColor),
            ),
            SizedBox(
              height: 8,
              child: Visibility(
                visible: currDay.isToday,
                child: Icon(
                  Icons.circle,
                  color: dotColor,
                  size: 8,
                ),
              ),
            )
            // Text(currDay.isToday ? "." : "")
          ],
        ),
      ),
    );
  }
}
