import 'package:intl/intl.dart';

class MyDateUtils {
  static String formatTaskDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

// static extractDateOnly(DateTime dateTime) {
//   //ignore time
//   return DateTime(dateTime.year,
//       dateTime.month,
//       dateTime.day);
// }
}
//extension function
// class msh 3amlah zy datetime  azod 3lih

extension DateTimeExtension on DateTime {
  DateTime extractDateOnly() {
    //inside class datetime scoop
    return DateTime(this.year, this.month, this.day);
  }
}
