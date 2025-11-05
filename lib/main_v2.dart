import 'package:flutter/material.dart';

void main() {
  runApp(const ShorebirdFinanceV2App());
}

class ShorebirdFinanceV2App extends StatelessWidget {
  const ShorebirdFinanceV2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const FinanceHomeV2(),
    );
  }
}

class FinanceHomeV2 extends StatefulWidget {
  const FinanceHomeV2({super.key});

  @override
  State<FinanceHomeV2> createState() => _FinanceHomeV2State();
}

class _FinanceHomeV2State extends State<FinanceHomeV2> {
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _depreciationController = TextEditingController();
  double _profit = 0;

  @override
  void dispose() {
    _revenueController.dispose();
    _expenseController.dispose();
    _depreciationController.dispose();
    super.dispose();
  }

  double _toDouble(String value) {
    return double.tryParse(value.trim()) ?? 0;
  }

  void _calculateProfit() {
    final double revenue = _toDouble(_revenueController.text);
    final double expense = _toDouble(_expenseController.text);
    final double depreciation = _toDouble(_depreciationController.text);
    setState(() {
      _profit = revenue - expense - depreciation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Shorebird Finance Demo (Patched)'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1504384308090-c894fdcc538d'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black.withOpacity(0.25),
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
                const SizedBox(height: 12),
                TextField(
                  controller: _depreciationController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Depreciation'),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _calculateProfit,
                  child: const Text('Calculate Profit'),
                ),
                const SizedBox(height: 12),
                Text(
                  'Profit: ${_profit.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const Spacer(),
                const Text(
                  'App version: 1.0.1 — Patched by Shorebird 🕊️',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


