class CarbonFootprint {
  final String unitOfMeasure;
  final List<CarbonFootprintEntry> data;

  CarbonFootprint({required this.unitOfMeasure, required this.data});

  factory CarbonFootprint.fromJson(Map<String, dynamic> json) {
    var list =
        (json["dati"] as List)
            .map((item) => CarbonFootprintEntry.fromJson(item))
            .toList();

    return CarbonFootprint(unitOfMeasure: json["unita_di_misura"], data: list);
  }
}

class CarbonFootprintEntry {
  final String area;
  final int year2022;
  final int year2023;

  CarbonFootprintEntry({
    required this.area,
    required this.year2022,
    required this.year2023,
  });

  factory CarbonFootprintEntry.fromJson(Map<String, dynamic> json) {
    return CarbonFootprintEntry(
      area: json["area"],
      year2022: json["2022"],
      year2023: json["2023"],
    );
  }
}
