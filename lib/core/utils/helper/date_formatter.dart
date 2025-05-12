import 'package:intl/intl.dart';

class DateFormatter {
  static String getFormatedDate(DateTime dateTime,[bool withTime=false]) {
    if(withTime){
      return    DateFormat('dd/MM/yyyy HH:mm a').format(dateTime);
    }
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
  static DateTime getStandardFormatOfDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return dateTime;

  }
}
