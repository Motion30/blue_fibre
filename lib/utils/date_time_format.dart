import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeFormatter {
  static String formatData(Timestamp timestamp) {
    final String month = getMonth(timestamp.toDate().month);
    final int day = timestamp.toDate().day;
    final int year = timestamp.toDate().year;
    final int hour = timestamp.toDate().hour;
    final int min = timestamp.toDate().minute;

    return '$day, $month $year ${hour < 9 ? '0' : ''}$hour:$min';
  }

  static String formatPostTime(Timestamp timestamp) {
    final String month = getMonth(timestamp.toDate().month);
    final int day = timestamp.toDate().day;
    final int year = timestamp.toDate().year;

    return '$day $month ${year == DateTime.now().year ? '' : year}';
  }

  static String getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
        break;
      case 2:
        return 'Feb';
        break;
      case 3:
        return 'Mar';
        break;
      case 4:
        return 'Apr';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'Jun';
        break;
      case 7:
        return 'Jul';
        break;
      case 8:
        return 'Aug';
        break;
      case 9:
        return 'Sep';
        break;
      case 10:
        return 'Oct';
        break;
      case 11:
        return 'Nov';
        break;
      case 12:
        return 'Dec';
        break;
      default:
        return '';
        break;
    }
  }
}
