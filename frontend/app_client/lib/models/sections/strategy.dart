class UniversityRanking {
  final String name;
  final int positionInItaly;
  final int? positionInTheWorld;
  final String? comment;

  UniversityRanking({
    required this.name,
    required this.positionInItaly,
    this.positionInTheWorld,
    this.comment,
  });

  factory UniversityRanking.fromJson(Map<String, dynamic> json) {
    return UniversityRanking(
      name: json["nome"],
      positionInItaly: json["posizione_italia"],
      positionInTheWorld: json["posizione_mondo"],
      comment: json["commento"],
    );
  }
}

class Facilities {
  final int schoolAmount;
  final int departmentAmount;

  Facilities({required this.schoolAmount, required this.departmentAmount});

  factory Facilities.fromJson(Map<String, dynamic> json) {
    return Facilities(
      schoolAmount: json["scuole"],
      departmentAmount: json["dipartimenti"],
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

class StrategicCosts {
  final String unitOfMeasurement;
  final List<StrategicCostScope> scopes;

  StrategicCosts({required this.unitOfMeasurement, required this.scopes});

  factory StrategicCosts.fromJson(Map<String, dynamic> json) {
    final scopeList =
        (json["ambiti"] as List)
            .map((e) => StrategicCostScope.fromJson(e))
            .toList();
    return StrategicCosts(
      unitOfMeasurement: json["unita_di_misura"],
      scopes: scopeList,
    );
  }
}

class StrategyData {
  final List<UniversityRanking> rankings;
  final Facilities facilities;
  final StrategicCosts strategicCosts;

  StrategyData({
    required this.rankings,
    required this.facilities,
    required this.strategicCosts,
  });

  factory StrategyData.fromJson(Map<String, dynamic> json) {
    final rankingList =
        (json["ranking_universitario"] as List)
            .map((e) => UniversityRanking.fromJson(e))
            .toList();
    final facilities = Facilities.fromJson(json["strutture"]);
    final strategicCosts = StrategicCosts.fromJson(
      json["costi_per_nome_strategico"],
    );
    return StrategyData(
      rankings: rankingList,
      facilities: facilities,
      strategicCosts: strategicCosts,
    );
  }
}
