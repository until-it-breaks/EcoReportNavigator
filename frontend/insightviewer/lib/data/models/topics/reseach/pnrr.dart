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
