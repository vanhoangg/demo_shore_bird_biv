import 'package:flutter/material.dart';
import '../../../theme/finance_theme.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField({
    required this.controller,
    required this.label,
    required this.theme,
    required this.onChanged,
    super.key,
    this.fieldKey,
  });

  final TextEditingController controller;
  final String label;
  final FinanceThemeData theme;
  final ValueChanged<String> onChanged;
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) => TextField(
    key: fieldKey,
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    onChanged: onChanged,
    style: TextStyle(
      color: theme.primaryTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: theme.inputLabelColor, fontSize: 16),
      filled: true,
      fillColor: theme.inputFillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.inputBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.primaryTextColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
  );
}
