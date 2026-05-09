import 'package:flutter/material.dart';

import '../../data/repositories/onboarding_repository.dart';
import '../plan/plan_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final TextEditingController _controller = TextEditingController();
  final OnboardingRepository _repository = OnboardingRepository();

  bool _loading = false;

  Future<void> _handleGeneratePlan() async {
    final text = _controller.text.trim();
    if (text.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入至少5个字的学习目标描述')),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final parsed = await _repository.parseGoal(text);
      final plan = await _repository.generatePlan(parsed);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PlanPage(plan: plan)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('生成失败：$e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设定学习目标')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: '例如：我要30天备考证券从业，每天3小时，偏好视频学习',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _handleGeneratePlan,
                child: _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('AI解析并生成计划'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
