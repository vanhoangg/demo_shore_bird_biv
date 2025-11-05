import 'package:flutter/material.dart';

void main() {
  runApp(const ShorebirdFinanceV1App());
}

class ShorebirdFinanceV1App extends StatelessWidget {
  const ShorebirdFinanceV1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const FinanceHomeV1(),
    );
  }
}

class FinanceHomeV1 extends StatefulWidget {
  const FinanceHomeV1({super.key});

  @override
  State<FinanceHomeV1> createState() => _FinanceHomeV1State();
}

class _FinanceHomeV1State extends State<FinanceHomeV1> {
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  double _profit = 0;

  @override
  void dispose() {
    _revenueController.dispose();
    _expenseController.dispose();
    super.dispose();
  }

  double _toDouble(String value) {
    return double.tryParse(value.trim()) ?? 0;
  }

  void _calculateProfit() {
    final double revenue = _toDouble(_revenueController.text);
    final double expense = _toDouble(_expenseController.text);
    setState(() {
      _profit = revenue - expense;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: const Text('Shorebird Finance Demo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _revenueController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Revenue'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _expenseController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Expense'),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _calculateProfit,
                child: const Text('Calculate Profit'),
              ),
              const SizedBox(height: 12),
              Text('Profit: ${_profit.toStringAsFixed(2)}'),
              const Spacer(),
              const Text(
                'App version: 1.0.0',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


