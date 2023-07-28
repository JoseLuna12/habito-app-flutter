class HabiDay {
  final DateTime date;
  bool _isToday = false;
  bool _isActive = false;
  HabiDay({required this.date, bool? today}) {
    _isToday = today ?? false;
    _isActive = today ?? false;
  }

  bool get isToday => _isToday;
  bool get isActive => _isActive;

  String get weekDayLong {
    return getWeekDayLong(date.weekday);
  }

  int get indexOfDay {
    return date.weekday - 1;
  }

  int get dayOfTheMonth {
    return date.day;
  }

  String get weekDayShort {
    return getWeekDayShort(date.weekday);
  }

  String get monthLong {
    return getMonthLong(date.month);
  }

  String get monthShort {
    return getMonthShort(date.month);
  }

  String get keyDate {
    final day = date.day;
    final month = date.month;
    final year = date.year;

    final dayParsed = day < 10 ? '0$day' : day.toString();
    final monthParsed = month < 10 ? '0$month' : month.toString();

    return "$dayParsed:$monthParsed:$year";
  }

  static String getMonthLong(int monthNum) {
    return switch (monthNum) {
      1 => "January",
      2 => "February",
      3 => "March",
      4 => "April",
      5 => "May",
      6 => "June",
      7 => "July",
      8 => "August",
      9 => "September",
      10 => "October",
      11 => "November",
      12 => "December",
      _ => throw "Month n $monthNum not supported"
    };
  }

  static String getMonthShort(int monthNum) {
    return switch (monthNum) {
      1 => "Jan",
      2 => "Feb",
      3 => "Mar",
      4 => "Apr",
      5 => "May",
      6 => "Jun",
      7 => "Jul",
      8 => "Aug",
      9 => "Sep",
      10 => "Oct",
      11 => "Nov",
      12 => "Dec",
      _ => throw "Month n $monthNum not supported"
    };
  }

  static String getWeekDayLong(int weekday) {
    return switch (weekday) {
      1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday",
      7 => "Sunday",
      _ => throw "Day $weekday not supported"
    };
  }

  static String getWeekDayShort(int weekday) {
    return switch (weekday) {
      1 => "Mon",
      2 => "Tue",
      3 => "Wed",
      4 => "Thu",
      5 => "Fri",
      6 => "Sat",
      7 => "Sun",
      _ => throw "Day $weekday not supported"
    };
  }

  void setTodayValue(HabiDay time) {
    if (time.keyDate == keyDate) {
      _isToday = true;
    } else {
      _isToday = false;
    }
  }

  void setIsActive(bool active) {
    _isActive = active;
  }
}
