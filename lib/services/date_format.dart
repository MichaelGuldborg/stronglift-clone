const monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const weekDayNames = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

class DateFormat {
  static String getFutureDateText(DateTime? dateTime) {
    if (dateTime == null) return '';
    var now = DateTime.now();
    var days = dateTime.day - now.day;
    if (days < 1) {
      return 'Today';
    } else if (days < 2) {
      return 'Tomorrow';
    } else if (days <= 7) {
      return weekDayNames[dateTime.weekday - 1];
    } else {
      final month = monthNames[dateTime.month - 1].substring(0, 3).toLowerCase();
      return '${dateTime.day}. $month';
    }
  }

  static String getPastDateText(DateTime? dateTime) {
    if (dateTime == null) return '';
    var dateTimeNow = DateTime.now();
    var diff = dateTimeNow.difference(dateTime);
    // var seconds = diff.inSeconds;
    // var minutes = diff.inMinutes;
    var hours = diff.inHours;
    var days = diff.inDays;
    // if (seconds <= 1) {
    //   return '1 sec';
    // } else if (seconds <= 60) {
    //   return '$seconds sec';
    // } else if (minutes <= 1) {
    //   return '1 min';
    // } else if (minutes < 60) {
    //   return '$minutes min';
    // }
    if (hours < 24) {
      return getHourText(dateTime);
    } else if (days <= 7) {
      final weekDayShort = weekDayNames[dateTime.weekday - 1].toLowerCase().substring(0, 3);
      return '$weekDayShort.';
    } else {
      final month = monthNames[dateTime.month - 1].substring(0, 3).toLowerCase();
      return '${dateTime.day}. $month';
    }
  }

  static String twoDigit(int number) {
    return number.toString().padLeft(2, '0');
  }

  static String getHourText(DateTime dateTime) {
    return '${twoDigit(dateTime.hour)}.${twoDigit(dateTime.minute)}';
  }

  static String getHourIntervalText(DateTime start, DateTime end) {
    return '${getHourText(start)} - ${getHourText(end)}';
  }

  static String getDateTimeText(DateTime dateTime) {
    return '${dateTime.day}. ${monthNames[dateTime.month - 1]}. ${getHourText(dateTime)}';
  }

  static String getDateText(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.day}. ${monthNames[dateTime.month - 1]} ${dateTime.year}';
  }

  static String getShortDateText(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.day}. ${monthNames[dateTime.month - 1].substring(0, 3)}';
  }
}
