class SocietyData {
  final SocietySummary societySummary;
  final InternshipAgreementsData internshipAgreements;
  final Events events;
  SocietyData({
    required this.societySummary,
    required this.internshipAgreements,
    required this.events,
  });

  factory SocietyData.fromJson(Map<String, dynamic> json) {
    return SocietyData(
      societySummary: SocietySummary.fromJson(json["societa"]),
      internshipAgreements: InternshipAgreementsData.fromJson(
        json["convenzioni_attive_per_tirocini_2023"],
      ),
      events: Events.fromJson(json["eventi"]),
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
  final List<InternshipAgreementCategory> categories;
  final int totalAgreements;

  InternshipAgreementsData({
    required this.categories,
    required this.totalAgreements,
  });

  factory InternshipAgreementsData.fromJson(Map<String, dynamic> json) {
    return InternshipAgreementsData(
      categories:
          (json["categorie"] as List)
              .map((item) => InternshipAgreementCategory.fromJson(item))
              .toList(),
      totalAgreements: json["convenzioni_totali"],
    );
  }
}

class InternshipAgreementCategory {
  final String category;
  final String percentage;

  InternshipAgreementCategory({
    required this.category,
    required this.percentage,
  });

  factory InternshipAgreementCategory.fromJson(Map<String, dynamic> json) {
    return InternshipAgreementCategory(
      category: json["categoria"],
      percentage: json["percentuale"],
    );
  }
}

class Event {
  final String type;
  final int eventCount;

  Event({required this.type, required this.eventCount});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(type: json["tipologia"], eventCount: json["numero_eventi"]);
  }
}

class Events {
  final List<Event> events;

  Events({required this.events});

  factory Events.fromJson(List<dynamic> jsonList) {
    return Events(events: jsonList.map((e) => Event.fromJson(e)).toList());
  }
}
