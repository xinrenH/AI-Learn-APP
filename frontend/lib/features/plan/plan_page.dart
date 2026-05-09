import 'package:flutter/material.dart';

import '../../data/models/study_plan.dart';
import '../../data/repositories/onboarding_repository.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key, this.plan});

  final StudyPlan? plan;

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final OnboardingRepository _repository = OnboardingRepository();

  StudyPlan? _plan;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  Future<void> _loadPlan() async {
    if (widget.plan != null) {
      setState(() {
        _plan = widget.plan;
        _loading = false;
      });
      return;
    }

    try {
      final today = await _repository.fetchTodayPlan();
      if (!mounted) return;
      setState(() {
        _plan = today;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('今日计划')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _plan == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(_error ?? '暂无计划，请先在目标页生成'),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      _plan!.goal,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text('周期 ${_plan!.periodDays} 天 · 每日 ${_plan!.dailyHours} 小时'),
                    const SizedBox(height: 6),
                    Text('复习策略：${_plan!.reviewStrategy}'),
                    const SizedBox(height: 16),
                    ..._plan!.tasks.map(
                      (task) => Card(
                        child: ListTile(
                          leading: Icon(task.type == 'video' ? Icons.play_circle_fill : Icons.task_alt),
                          title: Text(task.title),
                          subtitle: Text('第${task.day}天 · ${task.durationMinutes} 分钟'),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
