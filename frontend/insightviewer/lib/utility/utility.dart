import 'package:flutter/material.dart';
import 'package:insightviewer/data/models/value_with_unit.dart';
import 'package:intl/intl.dart';

double parsePercentage(String raw) {
  final normalized = raw.replaceAll("%", "").replaceAll(",", ".").trim();
  return double.tryParse(normalized) ?? 0.0;
}

String formatIntWithThousandsSeparator(int value) {
  final formatter = NumberFormat.decimalPattern("it_IT");
  return formatter.format(value);
}

String formatValueWithUnitWithThousandsSeparator(ValueWithUnit valueWithUnit) {
  final formatter = NumberFormat.decimalPattern("it_IT");
  return "${formatter.format(valueWithUnit.value)} ${valueWithUnit.unitOfMeasure}";
}

Future<T?> safeFetch<T, R>(
  Future<dynamic> Function() fetcher,
  T Function(R) fromJson,
  String logLabel,
) async {
  try {
    final json = await fetcher();
    return fromJson(json.data as R);
  } catch (e, st) {
    debugPrint('Error loading $logLabel: $e\n$st');
    return null;
  }
}
