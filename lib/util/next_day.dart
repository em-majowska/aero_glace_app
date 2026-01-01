bool isNextDay(DateTime date) {
  final now = DateTime.now();
  final nextCheck = DateTime(date.year, date.month, date.day);
  final nextDay = nextCheck.add(const Duration(days: 1));
  return now.isAfter(nextDay);
}
