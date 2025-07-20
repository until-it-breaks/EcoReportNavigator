import 'package:insightviewer/data/models/value_with_unit.dart';

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
