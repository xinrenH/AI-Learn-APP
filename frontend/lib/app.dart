import 'package:flutter/material.dart';

import 'features/home/home_page.dart';
import 'features/onboarding/onboarding_page.dart';
import 'features/plan/plan_page.dart';

class ZhiYuXueTuApp extends StatelessWidget {
  const ZhiYuXueTuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '智驭学途',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1572A1)),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const HomePage(),
        '/onboarding': (_) => const OnboardingPage(),
        '/plan': (_) => const PlanPage(),
      },
      initialRoute: '/',
    );
  }
}
