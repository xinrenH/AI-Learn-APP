import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_response.dart';
import '../models/goal_parse_result.dart';
import '../models/study_plan.dart';

class OnboardingRepository {
  Future<GoalParseResult> parseGoal(String text) async {
    final response = await ApiClient.dio.post(
      ApiEndpoints.goalParse,
      data: {'text': text},
    );
    final data = ApiResponseParser.requireData(response);
    return GoalParseResult.fromJson(data);
  }

  Future<StudyPlan> generatePlan(GoalParseResult parsed) async {
    final response = await ApiClient.dio.post(
      ApiEndpoints.planGenerate,
      data: {
        'goal': parsed.goal,
        'period_days': parsed.periodDays,
        'daily_hours': parsed.dailyHours,
        'level': parsed.level,
        'preference': parsed.preference,
      },
    );
    final data = ApiResponseParser.requireData(response);
    return StudyPlan.fromJson(data);
  }

  Future<StudyPlan> fetchTodayPlan() async {
    final response = await ApiClient.dio.get(ApiEndpoints.planToday);
    final data = ApiResponseParser.requireData(response);
    return StudyPlan.fromJson(data);
  }
}
