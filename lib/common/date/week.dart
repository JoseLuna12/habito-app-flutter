import 'package:habito/common/date/date.dart';

import 'day.dart';

typedef WeekList = List<List<HabiDay>>;

class HabiWeek {
  late int _todayWeekIndex;
  late WeekList _weeks;
  late final HabiDay _today;
  late HabiDay _activeDay;
  late int _activeWeekIndex;

  HabiWeek() {
    _weeks = DateHelper.initDates();
    _today = DateHelper.getCurrentDate();
    _todayWeekIndex = _getCurrentWeekIndexOf(_weeks);
    _activeDay = _today;
    _activeWeekIndex = _todayWeekIndex;
  }

  int get todayWeekIndex => _todayWeekIndex;
  WeekList get weeks => _weeks;
  HabiDay get today => _today;
  HabiDay get activeDay => _activeDay;
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
    _weeks[_activeWeekIndex][_activeDay.indexOfDay].setIsActive(false);
    _weeks[week][day].setIsActive(true);
    _activeDay = _weeks[week][day];
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
