
import 'package:intl/intl.dart';

extension DateExt on DateTime {

  num daysToToday(){
    return DateTime.now().difference(this).inDays;
  }

  String formatDateTime({String format = "EEEE, d MMMM, y h:mm a"}) {
    String formattedString = DateFormat(format).format(this);
    return formattedString;
  }

}