import 'package:flutter/material.dart';
import 'package:habito/common/date/week.dart';
import 'package:habito/common/providers/week_provider.dart';
import 'package:habito/features/routines/widgets/day_item.dart';
import 'package:provider/provider.dart';

class DaySelector extends StatefulWidget {
  const DaySelector({
    super.key,
  });

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  late HabiWeek allWeeks = context.watch<WeekProvider>().weeksValues;
  late final PageController weeksPageController =
      PageController(initialPage: allWeeks.activeWeekIndex);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 73,
      child: Row(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                context.read<WeekProvider>().onWeekChange(value);
                if (value == allWeeks.weeks.length - 1) {
                  context.read<WeekProvider>().addWeekToEnd();
                } else if (value == 0) {
                  context.read<WeekProvider>().addWeekToStart();
                  weeksPageController.jumpTo(
                    weeksPageController.position.pixels +
                        weeksPageController.position.viewportDimension,
                  );
                }
              },
              controller: weeksPageController,
              itemCount: allWeeks.weeks.length,
              itemBuilder: (context, index) {
                return Row(
                  key: ValueKey(index),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    allWeeks.weeks[index].length,
                    (dayIndex) {
                      final currDay = allWeeks.weeks[index][dayIndex];
                      return DayListItem(
                        currDay: currDay,
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
