class AppUtils {
  static final Map<int, String> dayOfWeek = {
    DateTime.monday: 'mo',
    DateTime.tuesday: 'tu',
    DateTime.wednesday: 'we',
    DateTime.thursday: 'th',
    DateTime.friday: 'fr',
    DateTime.saturday: 'sa',
    DateTime.sunday: 'su'
  };

  static final Map<int, String> _months = {
    DateTime.january: 'January',
    DateTime.february: 'February',
    DateTime.march: 'March',
    DateTime.april: 'April',
    DateTime.may: 'May',
    DateTime.june: 'June',
    DateTime.july: 'July',
    DateTime.august: 'August',
    DateTime.september: 'September',
    DateTime.october: 'October',
    DateTime.november: 'November',
    DateTime.december: 'December'
  };

  static String monthName(int month) {
    return _months[month] ?? '$month';
  }

  static String dayAsString(int day) {
    return dayOfWeek[day] ?? '$day';
  }
}
