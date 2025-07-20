import 'package:insightviewer/data/models/value_with_unit.dart';

class EconomicValueSummary {
  final ValueWithUnit attractedValue;
  final ValueWithUnit distributedValue;
  final ValueWithUnit fivePerThousand;
  final String greenPurchasesPercentage;

  EconomicValueSummary({
    required this.attractedValue,
    required this.distributedValue,
    required this.fivePerThousand,
    required this.greenPurchasesPercentage,
  });

  factory EconomicValueSummary.fromJson(Map<String, dynamic> json) {
    return EconomicValueSummary(
      attractedValue: ValueWithUnit.fromJson(json["valore_attratto"]),
      distributedValue: ValueWithUnit.fromJson(json["valore_distribuito"]),
      fivePerThousand: ValueWithUnit.fromJson(json["5x1000"]),
      greenPurchasesPercentage: json["percentuale_acquisti_verdi"],
    );
  }
}
