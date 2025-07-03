class EnvironmentData {
  final EnvironmentSummary summary;
  final List<EnergyPlanMilestone> energyPlanMilestones;
  final CarbonFootprint carbonFootprint;

  EnvironmentData({
    required this.summary,
    required this.energyPlanMilestones,
    required this.carbonFootprint,
  });

  factory EnvironmentData.fromJson(Map<String, dynamic> json) {
    return EnvironmentData(
      summary: EnvironmentSummary.fromJson(json["ambiente"]),
      energyPlanMilestones:
          (json["milestone_piano_energetico"] as List)
              .map((item) => EnergyPlanMilestone.fromJson(item))
              .toList(),
      carbonFootprint: CarbonFootprint.fromJson(json["carbon_footprint"]),
    );
  }
}

class EnvironmentSummary {
  final MeasuredValue photovoltaicSurface;
  final int environmentalCourses;
  final MeasuredValue renewableEnergy;
  final int subsidizedSubscriptions;
  final MeasuredValue subscriptionSpending;

  EnvironmentSummary({
    required this.photovoltaicSurface,
    required this.environmentalCourses,
    required this.renewableEnergy,
    required this.subsidizedSubscriptions,
    required this.subscriptionSpending,
  });

  factory EnvironmentSummary.fromJson(Map<String, dynamic> json) {
    return EnvironmentSummary(
      photovoltaicSurface: MeasuredValue.fromJson(
        json["superficie_fotovoltaica"],
      ),
      environmentalCourses: json["insegnamenti_tematiche_ambientali"],
      renewableEnergy: MeasuredValue.fromJson(
        json["energia_fonti_rinnovabili"],
      ),
      subsidizedSubscriptions: json["abbonamenti_agevolati"],
      subscriptionSpending: MeasuredValue.fromJson(
        json["spesa_abbonamenti_agevolati"],
      ),
    );
  }
}

class MeasuredValue {
  final num value;
  final String unit;

  MeasuredValue({required this.value, required this.unit});

  factory MeasuredValue.fromJson(Map<String, dynamic> json) {
    return MeasuredValue(value: json["valore"], unit: json["unita_di_misura"]);
  }
}

class EnergyPlanMilestone {
  final String activity;
  final int startYear;
  final int endYear;

  EnergyPlanMilestone({
    required this.activity,
    required this.startYear,
    required this.endYear,
  });

  factory EnergyPlanMilestone.fromJson(Map<String, dynamic> json) {
    return EnergyPlanMilestone(
      activity: json["attivita"],
      startYear: json["anno_inizio"],
      endYear: json["anno_fine"],
    );
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
      area: json['area'],
      year2022: json['2022'],
      year2023: json['2023'],
    );
  }
}

class CarbonFootprint {
  final String unitOfMeasure;
  final List<CarbonFootprintEntry> data;

  CarbonFootprint({required this.unitOfMeasure, required this.data});

  factory CarbonFootprint.fromJson(Map<String, dynamic> json) {
    var list =
        (json['dati'] as List)
            .map((item) => CarbonFootprintEntry.fromJson(item))
            .toList();

    return CarbonFootprint(unitOfMeasure: json['unita_di_misura'], data: list);
  }
}
