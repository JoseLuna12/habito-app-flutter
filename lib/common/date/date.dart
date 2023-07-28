import 'package:habito/common/date/day.dart';

class DateHelper {
  static HabiDay getCurrentDate() {
    return HabiDay(date: DateTime.now(), today: true);
  }

  static List<List<HabiDay>> initDates({HabiDay? from}) {
    // final fromDate = from ?? getCurrentDate();

    final currentWeek = getCurrentWeek();
    final currentMonday = currentWeek[0];

    final nextWeek = getNextWeekFromMonday(currentMonday);
    final previusWeek = getPreviousWeekendFromMonday(currentMonday);

    return [previusWeek, currentWeek, nextWeek];
  }

  static List<HabiDay> getCurrentWeek() {
    final currentDay = getCurrentDate();

    int currentWeekday = currentDay.date.weekday;
    int daysUntilMonday = currentWeekday == 1 ? 0 : 1 - currentWeekday;

    DateTime monday = currentDay.date.add(Duration(days: daysUntilMonday));

    List<HabiDay> weekDates = [];
    for (int i = 0; i < 7; i++) {
      final newHabiday = HabiDay(
        date: monday.add(
          Duration(days: i),
        ),
      );
      if (newHabiday.keyDate == currentDay.keyDate) {
        newHabiday.setIsActive(true);
      }
      newHabiday.setTodayValue(currentDay);
      weekDates.add(newHabiday);
    }

    return weekDates;
  }

  static List<HabiDay> getPreviousWeekendFromMonday(HabiDay monday) {
    final currentDay = getCurrentDate();
    DateTime nextMonday = monday.date.subtract(const Duration(days: 7));
    List<HabiDay> weekDates = [];

    for (int i = 0; i < 7; i++) {
      final newHabiday = HabiDay(
        date: nextMonday.add(
          Duration(days: i),
        ),
      );
      newHabiday.setTodayValue(currentDay);
      weekDates.add(newHabiday);
    }

    return weekDates;
  }

  static List<HabiDay> getNextWeekFromMonday(HabiDay monday) {
    final currentDay = getCurrentDate();
    DateTime nextMonday = monday.date.add(const Duration(days: 7));
    List<HabiDay> weekDates = [];

    for (int i = 0; i < 7; i++) {
      final newHabiday = HabiDay(
        date: nextMonday.add(
          Duration(days: i),
        ),
      );
      newHabiday.setTodayValue(currentDay);
      weekDates.add(newHabiday);
    }

    return weekDates;
  }
}
