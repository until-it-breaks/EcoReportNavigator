import 'package:app_client/data/models/value_with_unit.dart';

class PeopleData {
  final PeopleSummary summary;
  final RemoteWorkData remoteWorkStats;

  PeopleData({required this.summary, required this.remoteWorkStats});

  factory PeopleData.fromJson(Map<String, dynamic> json) {
    return PeopleData(
      summary: PeopleSummary.fromJson(json["persone"]),
      remoteWorkStats: RemoteWorkData.fromJson(
        json["i_numeri_del_lavoro_a_distanza"],
      ),
    );
  }
}

class PeopleSummary {
  final Personnel docenteRicercatore;
  final Personnel tecnicoAmministrativo;
  final TrainingHours formazione2023;
  final Welfare welfareTA;
  final int smartWorkingAgreements;
  final int teleworkProjects;

  PeopleSummary({
    required this.docenteRicercatore,
    required this.tecnicoAmministrativo,
    required this.formazione2023,
    required this.welfareTA,
    required this.smartWorkingAgreements,
    required this.teleworkProjects,
  });

  factory PeopleSummary.fromJson(Map<String, dynamic> json) {
    return PeopleSummary(
      docenteRicercatore: Personnel.fromJson(
        json["personale_docente_e_ricercatore"],
      ),
      tecnicoAmministrativo: Personnel.fromJson(
        json["personale_tecnico_amministrativo"],
      ),
      formazione2023: TrainingHours.fromJson(
        json["ore_di_formazione_fruite_dal_personale_nel_2023"],
      ),
      welfareTA: Welfare.fromJson(
        json["welfare_aziendale_per_il_personale_ta"],
      ),
      smartWorkingAgreements: json["accordi_di_smart_working"],
      teleworkProjects: json["progetti_di_telelavoro"],
    );
  }
}

class Personnel {
  final int value;
  final String percentageChange;

  Personnel({required this.value, required this.percentageChange});

  factory Personnel.fromJson(Map<String, dynamic> json) {
    return Personnel(
      value: json["valore"],
      percentageChange: json["variazione_percentuale"],
    );
  }
}

class TrainingHours {
  final int hours;
  final String percentageChange;

  TrainingHours({required this.hours, required this.percentageChange});

  factory TrainingHours.fromJson(Map<String, dynamic> json) {
    return TrainingHours(
      hours: json["ore"],
      percentageChange: json["variazione_percentuale"],
    );
  }
}

class Welfare extends ValueWithUnit {
  Welfare({required super.value, required super.unitOfMeasure});

  factory Welfare.fromJson(Map<String, dynamic> json) {
    return Welfare(
      value: json["valore"],
      unitOfMeasure: json["unita_di_misura"],
    );
  }
}

class RemoteWorkStats {
  final String type;
  final int? year2021;
  final int? year2022;
  final int? year2023;

  RemoteWorkStats({
    required this.type,
    this.year2021,
    this.year2022,
    this.year2023,
  });

  factory RemoteWorkStats.fromJson(Map<String, dynamic> json) {
    return RemoteWorkStats(
      type: json["tipologia"],
      year2021: json["2021"],
      year2022: json["2022"],
      year2023: json["2023"],
    );
  }
}

class RemoteWorkData {
  final List<RemoteWorkStats> entries;

  RemoteWorkData({required this.entries});

  factory RemoteWorkData.fromJson(List<dynamic> jsonList) {
    return RemoteWorkData(
      entries:
          jsonList.map((entry) => RemoteWorkStats.fromJson(entry)).toList(),
    );
  }
}
