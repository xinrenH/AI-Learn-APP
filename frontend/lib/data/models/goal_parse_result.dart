class GoalParseResult {
  GoalParseResult({
    required this.goal,
    required this.periodDays,
    required this.dailyHours,
    required this.preference,
    required this.level,
  });

  final String goal;
  final int periodDays;
  final double dailyHours;
  final String preference;
  final String level;

  factory GoalParseResult.fromJson(Map<String, dynamic> json) {
    return GoalParseResult(
      goal: json['goal'] as String,
      periodDays: json['period_days'] as int,
      dailyHours: (json['daily_hours'] as num).toDouble(),
      preference: json['preference'] as String,
      level: json['level'] as String,
    );
  }
}
