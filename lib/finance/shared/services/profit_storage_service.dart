import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum ProfitPeriod { daily, weekly, monthly }

class ProfitStorageEntry {
  ProfitStorageEntry({required this.profit, required this.timestamp});

  final double profit;
  final DateTime timestamp;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'profit': profit,
    'timestamp': timestamp.millisecondsSinceEpoch,
  };

  static ProfitStorageEntry fromJson(Map<String, dynamic> json) =>
      ProfitStorageEntry(
        profit: (json['profit'] as num).toDouble(),
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          json['timestamp'] as int,
        ),
      );
}

class ProfitStorageService {
  static const String _key = 'finance_profit_entries';

  static Future<void> saveProfit(double profit) async {
    if (profit <= 0) {
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<ProfitStorageEntry> existing = await _loadEntries(prefs);
    existing.add(ProfitStorageEntry(profit: profit, timestamp: DateTime.now()));
    await prefs.setString(
      _key,
      jsonEncode(existing.map((ProfitStorageEntry e) => e.toJson()).toList()),
    );
  }

  static Future<List<ProfitStorageEntry>> getEntries(
    ProfitPeriod period,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<ProfitStorageEntry> entries = await _loadEntries(prefs);
    final DateTime now = DateTime.now();
    final DateTime start = switch (period) {
      ProfitPeriod.daily => DateTime(
        now.year,
        now.month,
        now.day,
      ), // today 00:00
      ProfitPeriod.weekly => now.subtract(
        Duration(days: now.weekday - 1),
      ), // start of week
      ProfitPeriod.monthly => DateTime(now.year, now.month),
    };

    return entries
        .where(
          (ProfitStorageEntry e) =>
              e.profit > 0 && !e.timestamp.isBefore(start),
        )
        .toList();
  }

  static Future<List<ProfitStorageEntry>> _loadEntries(
    SharedPreferences prefs,
  ) async {
    final String? data = prefs.getString(_key);
    if (data == null || data.isEmpty) {
      return <ProfitStorageEntry>[];
    }
    try {
      final List<dynamic> decoded = jsonDecode(data) as List<dynamic>;
      return decoded
          .map(
            (item) => ProfitStorageEntry.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (_) {
      return <ProfitStorageEntry>[];
    }
  }
}
