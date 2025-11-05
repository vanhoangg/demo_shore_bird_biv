import 'package:demo_shore_bird/finance_home_v1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ShorebirdFinanceApp());
}

class ShorebirdFinanceApp extends StatelessWidget {
  const ShorebirdFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const FinanceHomeV1(),
    );
  }
}
