class ResearchData {
  final ResearchSummary researchSummary;
  final Pnrr pnrr;

  ResearchData({required this.researchSummary, required this.pnrr});

  factory ResearchData.fromJson(Map<String, dynamic> json) {
    return ResearchData(
      researchSummary: ResearchSummary.fromJson(json["ricerca"]),
      pnrr: Pnrr.fromJson(json["pnrr"]),
    );
  }
}

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

class Pnrr {
  final List<MissionFund> fundDistributionByMission;

  Pnrr({required this.fundDistributionByMission});

  factory Pnrr.fromJson(Map<String, dynamic> json) {
    var list = json["ripartizione_fondi_per_missione"] as List;
    List<MissionFund> missions =
        list.map((i) => MissionFund.fromJson(i)).toList();

    return Pnrr(fundDistributionByMission: missions);
  }
}

class MissionFund {
  final String mission;
  final String percentage;

  MissionFund({required this.mission, required this.percentage});

  factory MissionFund.fromJson(Map<String, dynamic> json) {
    return MissionFund(
      mission: json["missione"],
      percentage: json["percentuale"],
    );
  }
}
