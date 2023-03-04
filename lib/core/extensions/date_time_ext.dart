import '../library/app_material.dart';

extension DateTimeEx on DateTime {
  String get toYMDString => '$day/$month/$year';

  String get dueDateFormat {
    String intiText = isToday ? 'Today' : toYMDString;
    String time = '$hour:$minute';
    return '$intiText At $time';
  }

  bool get isToday {
    return DateUtils.isSameDay(DateTime.now(), this);
  }
}
