import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/language_app_controller.dart';

String _dateFormatMonth(DateTime date) {
  return DateFormat(
    'dd MMM',
    Get.find<LanguagesAppController>().getCache(),
  ).format(date);
}

String _dateFormatYear(DateTime date) {
  return DateFormat(
    'dd MMM yyy',
    Get.find<LanguagesAppController>().getCache(),
  ).format(date);
}

String dateFormatDefault(DateTime? date) {
  if (date == null) return 'Дата не указана';
  var _now = DateTime.now();
  var _date = date;

  int dateYear = _now.year - _date.year;
  int dateMonth = _now.month - _date.month;
  int dateDay = _now.day - _date.day;
  int dateHour = _now.hour - _date.hour;
  int dateMinute = _now.minute - _date.minute;
  int dateSecound = _now.second - _date.second;

  if (dateYear >= 1) return _dateFormatYear(date);
  if (dateMonth >= 1) return _dateFormatMonth(date);
  if (dateDay >= 1) return '$dateDay д. назад';
  if (dateHour >= 1) return '$dateHour ч. назад';
  if (dateMinute >= 1) return '$dateMinute м. назад';
  if (dateSecound < 30) return 'только что';
  return '$dateSecound с. назад';
}
