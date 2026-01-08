/// Vérifie si un jour complet est passé depuis [date].
///
/// Cette fonction compare [date] avec la date actuelle et retourne `true`
/// si la date actuelle est **après minuit du jour suivant**.
///
/// [date] : la date à comparer avec aujourd'hui.
/// Retourne `true` si aujourd'hui est le jour suivant [date], sinon `false`.
bool isNextDay(DateTime date) {
  final now = DateTime.now();
  final nextCheck = DateTime(date.year, date.month, date.day).add(
    const Duration(days: 1),
  );

  return now.isAfter(nextCheck);
}
