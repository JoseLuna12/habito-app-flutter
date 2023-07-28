import 'package:habito/common/date/date.dart';

import 'day.dart';

typedef WeekList = List<List<HabiDay>>;

class HabiWeek {
  late int _todayWeekIndex;
  late WeekList _weeks;
  late final HabiDay _today;
  late int _activeWeekIndex;
  late int _activeDayIndex;

  HabiWeek() {
    _weeks = DateHelper.initDates();
    _today = DateHelper.getCurrentDate();
    _todayWeekIndex = _getCurrentWeekIndexOf(_weeks);
    _activeWeekIndex = _todayWeekIndex;
    _activeDayIndex = _today.indexOfDay;
  }

  int get todayWeekIndex => _todayWeekIndex;
  WeekList get weeks => _weeks;
  HabiDay get today => _today;
  HabiDay get todayInArray {
    return weeks[_todayWeekIndex][today.indexOfDay];
  }

  int get activeWeekIndex => _activeWeekIndex;

  int _getCurrentWeekIndexOf(WeekList weekList) {
    int currentIndex = 0;
    for (var (index, week) in weekList.indexed) {
      final isTodayWeek = week.any((element) => element.isToday);
      if (isTodayWeek) {
        currentIndex = index;
      }
    }
    return currentIndex;
  }

  void activateDayByIndex(int week, int day) {
    _weeks[_activeWeekIndex][_activeDayIndex].setIsActive(false);
    _weeks[week][day].setIsActive(true);
    _activeDayIndex = day;
    _activeWeekIndex = week;
  }

  void addWeekToEnd() {
    final lastWeek = _weeks.last;
    final nextWeek = DateHelper.getNextWeekFromMonday(lastWeek.first);
    _weeks.add(nextWeek);
    _todayWeekIndex = _todayWeekIndex - 1;
  }

  void addWeekToStart() {
    final firstWeek = _weeks.first;
    final previusWeek =
        DateHelper.getPreviousWeekendFromMonday(firstWeek.first);
    _weeks.insert(0, previusWeek);
    _todayWeekIndex = _todayWeekIndex + 1;
  }
}
