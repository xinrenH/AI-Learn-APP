class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';
  static const String goalParse = '/onboarding/goal-parse';
  static const String planGenerate = '/plan/generate';
  static const String planToday = '/plan/today';

  static String completeTask(String taskId) => '/plan/tasks/$taskId/complete';
}
