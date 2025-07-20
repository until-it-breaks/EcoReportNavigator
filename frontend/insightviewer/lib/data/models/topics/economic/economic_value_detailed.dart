class EconomicValueDetailed {
  final String unitOfMeasure;
  final List<EconomicValueEntry> entries;

  EconomicValueDetailed({required this.unitOfMeasure, required this.entries});

  factory EconomicValueDetailed.fromJson(Map<String, dynamic> json) {
    final list = json["dati"] as List<dynamic>;
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
