class StudyTask {
  StudyTask({
    required this.day,
    required this.type,
    required this.title,
    required this.durationMinutes,
    required this.resourceId,
  });

  final int day;
  final String type;
  final String title;
  final int durationMinutes;
  final String resourceId;

  factory StudyTask.fromJson(Map<String, dynamic> json) {
    return StudyTask(
      day: json['day'] as int,
      type: json['type'] as String,
      title: json['title'] as String,
      durationMinutes: json['duration_minutes'] as int,
      resourceId: json['resource_id'] as String,
    );
  }
}

class StudyPlan {
  StudyPlan({
    required this.goal,
    required this.periodDays,
    required this.dailyHours,
    required this.difficulty,
    required this.tasks,
    required this.reviewStrategy,
  });

  final String goal;
  final int periodDays;
  final double dailyHours;
  final String difficulty;
  final List<StudyTask> tasks;
  final String reviewStrategy;

  factory StudyPlan.fromJson(Map<String, dynamic> json) {
    final tasksRaw = json['tasks'] as List<dynamic>;
    return StudyPlan(
      goal: json['goal'] as String,
      periodDays: json['period_days'] as int,
      dailyHours: (json['daily_hours'] as num).toDouble(),
      difficulty: json['difficulty'] as String,
      tasks: tasksRaw
          .map((item) => StudyTask.fromJson(item as Map<String, dynamic>))
          .toList(),
      reviewStrategy: json['review_strategy'] as String,
    );
  }
}
