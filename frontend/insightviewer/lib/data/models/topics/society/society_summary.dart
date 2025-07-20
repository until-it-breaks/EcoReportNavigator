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
