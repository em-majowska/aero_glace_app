 bool isNextDay() {
    final now = DateTime.now();
    final nextDay = now.add(const Duration(days: 1));
    final nextCheck = nextDay.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );

    return now.isAfter(nextCheck);
  }