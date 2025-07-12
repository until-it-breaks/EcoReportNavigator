import 'package:app_client/data/models/value_with_unit.dart';
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
