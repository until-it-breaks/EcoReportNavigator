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

  static List<EnergyPlanMilestone> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => EnergyPlanMilestone.fromJson(item)).toList();
  }
}
