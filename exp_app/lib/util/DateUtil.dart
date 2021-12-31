class DateUtil {
  static const int minYear = 2021;

  static int maxDays(int year, int month) {
    if (month == 2) {
      return (year % 400 == 0 || (year % 4 == 00 && !(year % 100 == 0)))
          ? 29
          : 28;
    } else {
      if (month < 8) {
        return month % 2 == 0 ? 30 : 31;
      } else {
        return month % 2 == 0 ? 31 : 30;
      }
    }
  }
}
