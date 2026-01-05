bool isNextDay(DateTime date) {
  final now = DateTime.now();
  final nextCheck = DateTime(date.year, date.month, date.day).add(
    const Duration(days: 1),
  );

  return now.isAfter(nextCheck);
}
