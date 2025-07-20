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
