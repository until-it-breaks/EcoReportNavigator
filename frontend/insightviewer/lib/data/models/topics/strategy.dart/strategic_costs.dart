class StrategicCosts {
  final String unitOfMeasurement;
  final List<StrategicCostScope> scopes;

  StrategicCosts({required this.unitOfMeasurement, required this.scopes});

  factory StrategicCosts.fromJson(Map<String, dynamic> json) {
    final scopeList =
        (json["dati"] as List)
            .map((e) => StrategicCostScope.fromJson(e))
            .toList();
    return StrategicCosts(
      unitOfMeasurement: json["unita_di_misura"],
      scopes: scopeList,
    );
  }
}

class StrategicCostScope {
  final String name;
  final String percentage;

  StrategicCostScope({required this.name, required this.percentage});

  factory StrategicCostScope.fromJson(Map<String, dynamic> json) {
    return StrategicCostScope(
      name: json["nome"],
      percentage: json["percentuale"],
    );
  }
}
