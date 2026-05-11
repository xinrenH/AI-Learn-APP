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

  Future<void> _completeTask(String taskId) async {
    try {
      final updated = await _repository.completeTask(taskId);
      if (!mounted) return;
      setState(() {
        _plan = updated;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('打卡成功')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('打卡失败：$e')),
      );
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
                          leading: Icon(
                            task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: task.completed ? Colors.green : null,
                          ),
                          title: Text(task.title),
                          subtitle: Text('第${task.day}天 · ${task.durationMinutes} 分钟'),
                          trailing: task.completed
                              ? const Text('已完成')
                              : ElevatedButton(
                                  onPressed: () => _completeTask(task.taskId),
                                  child: const Text('完成打卡'),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
