bool isNextDay(DateTime date) {
  final now = DateTime.now();
  final nextCheck = DateTime(date.year, date.month, date.day).add(
    const Duration(seconds: 10),
  );

  return now.isAfter(nextCheck);
}
