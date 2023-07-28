import 'package:flutter/material.dart';
import 'package:habito/common/date/day.dart';
import 'package:habito/common/date/week.dart';

class WeekProvider extends ChangeNotifier {
  late final HabiWeek weeksValues;
  late int _currentPage;
  WeekProvider({required this.weeksValues}) {
    _currentPage = weeksValues.todayWeekIndex;
  }

  List<List<HabiDay>> get weeks => weeksValues.weeks;
  int get index => weeksValues.todayWeekIndex;
  int get currentPage => _currentPage;

  void selectDay(HabiDay day) {
    weeksValues.activateDayByIndex(_currentPage, day.indexOfDay);
    notifyListeners();
  }

  void onWeekChange(int page) {
    _currentPage = page;
    weeksValues.activateDayByIndex(page, 0);
    notifyListeners();
  }

  void addWeekToEnd() {
    weeksValues.addWeekToEnd();
    notifyListeners();
  }

  void addWeekToStart() {
    weeksValues.addWeekToStart();
    notifyListeners();
  }
}
