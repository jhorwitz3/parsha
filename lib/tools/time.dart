import 'package:intl/intl.dart';

class TimeTools {
  String todayDate() {
    // Get the current date
    DateTime now = DateTime.now();

    // Format the date using DateFormat from intl package
    String formattedDate = _formatDateWithOrdinal(now);

    return formattedDate;
  }

  String _formatDateWithOrdinal(DateTime date) {
    // Get the day of the week and month
    String dayOfWeek = DateFormat('EEEE').format(date);
    String month = DateFormat('MMMM').format(date);

    // Get the day of the month
    int day = date.day;

    // Add the appropriate ordinal suffix (st, nd, rd, th)
    String dayWithOrdinal = '$day${_getOrdinalSuffix(day)}';

    // Combine all parts
    return '$dayOfWeek, $month $dayWithOrdinal';
  }

  String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
