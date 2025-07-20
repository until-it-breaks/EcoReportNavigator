class InternshipAgreementsData {
  final List<InternshipAgreementCategory> agreements;
  final int totalAgreements;

  InternshipAgreementsData({
    required this.agreements,
    required this.totalAgreements,
  });

  factory InternshipAgreementsData.fromJson(Map<String, dynamic> json) {
    return InternshipAgreementsData(
      agreements:
          (json["dati"] as List)
              .map((item) => InternshipAgreementCategory.fromJson(item))
              .toList(),
      totalAgreements: json["convenzioni_totali"],
    );
  }
}

class InternshipAgreementCategory {
  final String name;
  final String percentage;

  InternshipAgreementCategory({required this.name, required this.percentage});

  factory InternshipAgreementCategory.fromJson(Map<String, dynamic> json) {
    return InternshipAgreementCategory(
      name: json["categoria"],
      percentage: json["percentuale"],
    );
  }
}
