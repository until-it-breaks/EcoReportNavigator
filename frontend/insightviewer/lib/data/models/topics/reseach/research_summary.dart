class ResearchSummary {
  final int horizonEuropeProjects;
  final int researchGrants;
  final int outgoingProfessors;
  final Investment cascadeFundingPnrrPnc;
  final int publications;
  final int visitingProfessorsAndPhd;

  ResearchSummary({
    required this.horizonEuropeProjects,
    required this.researchGrants,
    required this.outgoingProfessors,
    required this.cascadeFundingPnrrPnc,
    required this.publications,
    required this.visitingProfessorsAndPhd,
  });

  factory ResearchSummary.fromJson(Map<String, dynamic> json) {
    return ResearchSummary(
      horizonEuropeProjects: json["progetti_horizon_europe"],
      researchGrants: json["assegni_di_ricerca"],
      outgoingProfessors: json["docenti_outgoing"],
      cascadeFundingPnrrPnc: Investment.fromJson(
        json["investimenti_bandi_a_cascata_pnrr_e_pnc"],
      ),
      publications: json["pubblicazioni"],
      visitingProfessorsAndPhd: json["visiting_professors_e_phd"],
    );
  }
}

class Investment {
  final int value;
  final String unit;
  final String description;

  Investment({
    required this.value,
    required this.unit,
    required this.description,
  });

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      value: json["valore"],
      unit: json["unita_di_misura"],
      description: json["descrizione"],
    );
  }
}
