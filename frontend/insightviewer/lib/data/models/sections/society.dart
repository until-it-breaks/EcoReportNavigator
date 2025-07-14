class SocietyData {
  final SocietySummary societySummary;
  final InternshipAgreementsData internshipAgreements;
  final List<SocialEvent> socialEvents;
  SocietyData({
    required this.societySummary,
    required this.internshipAgreements,
    required this.socialEvents,
  });

  factory SocietyData.fromJson(Map<String, dynamic> json) {
    return SocietyData(
      societySummary: SocietySummary.fromJson(json["societa"]),
      internshipAgreements: InternshipAgreementsData.fromJson(
        json["convenzioni_attive_per_tirocini_2023"],
      ),
      socialEvents:
          (json["eventi"] as List)
              .map((item) => SocialEvent.fromJson(item))
              .toList(),
    );
  }
}

class SocietySummary {
  final int externallyFundedScholarships;
  final int eventsPromotedIn2023;
  final int documentaryHeritage;
  final int patentFamilies;
  final int spinOffsAndStartups;
  final int magazineArticlesAndEvents;
  final int museumVisitors;
  final int advancedAndContinuingEducationCourses;

  SocietySummary({
    required this.externallyFundedScholarships,
    required this.eventsPromotedIn2023,
    required this.documentaryHeritage,
    required this.patentFamilies,
    required this.spinOffsAndStartups,
    required this.magazineArticlesAndEvents,
    required this.museumVisitors,
    required this.advancedAndContinuingEducationCourses,
  });

  factory SocietySummary.fromJson(Map<String, dynamic> json) {
    return SocietySummary(
      externallyFundedScholarships:
          json["borse_di_studio_finanziate_dall_esterno"],
      eventsPromotedIn2023: json["eventi_promossi_nel_2023"],
      documentaryHeritage: json["patrimonio_documentario"],
      patentFamilies: json["famiglie_brevettuali"],
      spinOffsAndStartups: json["spin_off_e_startup"],
      magazineArticlesAndEvents: json["articoli_e_eventi_da_unibo_magazine"],
      museumVisitors: json["visitatori_musei"],
      advancedAndContinuingEducationCourses:
          json["corsi_di_alta_formazione_e_formazione_continua"],
    );
  }
}

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
          (json["categorie"] as List)
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

class SocialEvent {
  final String name;
  final int amount;

  SocialEvent({required this.name, required this.amount});

  factory SocialEvent.fromJson(Map<String, dynamic> json) {
    return SocialEvent(name: json["tipologia"], amount: json["numero_eventi"]);
  }
}
