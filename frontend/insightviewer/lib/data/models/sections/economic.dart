import 'package:insightviewer/data/models/value_with_unit.dart';

class EconomicData {
  final EconomicValueSummary summary;
  final EconomicValueDetailed attractedDetailed;
  final EconomicValueDetailed distributedDetailed;
  final GreenPurchases greenPurchases;

  EconomicData({
    required this.summary,
    required this.attractedDetailed,
    required this.distributedDetailed,
    required this.greenPurchases,
  });

  factory EconomicData.fromJson(Map<String, dynamic> json) {
    return EconomicData(
      summary: EconomicValueSummary.fromJson(json["valore_economico"]),
      attractedDetailed: EconomicValueDetailed.fromJson(
        json["valore_economico_attratto_2023"],
      ),
      distributedDetailed: EconomicValueDetailed.fromJson(
        json["valore_economico_distribuito_2023"],
      ),
      greenPurchases: GreenPurchases.fromJson(json["acquisti_green"]),
    );
  }
}

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

class EconomicValueDetailed {
  final String unitOfMeasure;
  final List<EconomicValueEntry> entries;

  EconomicValueDetailed({required this.unitOfMeasure, required this.entries});

  factory EconomicValueDetailed.fromJson(Map<String, dynamic> json) {
    final list = json["voci"] as List<dynamic>;
    final entriesList =
        list.map((e) => EconomicValueEntry.fromJson(e)).toList();

    return EconomicValueDetailed(
      unitOfMeasure: json["unita_di_misura"],
      entries: entriesList,
    );
  }
}

class EconomicValueEntry {
  final String name;
  final num value;
  final String percentage;

  EconomicValueEntry({
    required this.name,
    required this.value,
    required this.percentage,
  });

  factory EconomicValueEntry.fromJson(Map<String, dynamic> json) {
    return EconomicValueEntry(
      name: json["nome"],
      value: json["valore"],
      percentage: json["percentuale"],
    );
  }
}

class GreenPurchases {
  final String percentageOf2022;
  final String percentageOf2023;
  final String targetPercentageOf2024;

  GreenPurchases({
    required this.percentageOf2023,
    required this.percentageOf2022,
    required this.targetPercentageOf2024,
  });

  factory GreenPurchases.fromJson(Map<String, dynamic> json) {
    return GreenPurchases(
      percentageOf2022: json["percentuale_2022"],
      percentageOf2023: json["percentuale_2023"],
      targetPercentageOf2024: json["target_2024"],
    );
  }
}
