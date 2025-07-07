class PeopleData {
  final PeopleSummary summary;
  final AcademicStaffByRole academicStaffByRole;
  final AdministrativeStaffByYear administrativeStaffByYear;
  final RemoteWorkData remoteWorkStats;

  PeopleData({
    required this.summary,
    required this.academicStaffByRole,
    required this.administrativeStaffByYear,
    required this.remoteWorkStats,
  });

  factory PeopleData.fromJson(Map<String, dynamic> json) {
    return PeopleData(
      summary: PeopleSummary.fromJson(json["persone"]),
      academicStaffByRole: AcademicStaffByRole.fromJson(
        json["personale_docente_e_ricercatore"],
      ),
      administrativeStaffByYear: AdministrativeStaffByYear.fromJson(
        json["personale_ta_full_time_part_time"],
      ),
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

class Welfare {
  final int value;
  final String unitOfMeasure;

  Welfare({required this.value, required this.unitOfMeasure});

  factory Welfare.fromJson(Map<String, dynamic> json) {
    return Welfare(
      value: json["valore"],
      unitOfMeasure: json["unita_di_misura"],
    );
  }
}

class AcademicStaffByRole {
  final List<AcademicStaffYearData> fullProfessors;
  final List<AcademicStaffYearData> associateProfessors;
  final List<AcademicStaffYearData> permanentResearchers;
  final List<AcademicStaffYearData> fixedTermResearchers;

  AcademicStaffByRole({
    required this.fullProfessors,
    required this.associateProfessors,
    required this.permanentResearchers,
    required this.fixedTermResearchers,
  });

  factory AcademicStaffByRole.fromJson(Map<String, dynamic> json) {
    return AcademicStaffByRole(
      fullProfessors:
          (json["ordinario"] as List)
              .map((e) => AcademicStaffYearData.fromJson(e))
              .toList(),
      associateProfessors:
          (json["associato"] as List)
              .map((e) => AcademicStaffYearData.fromJson(e))
              .toList(),
      permanentResearchers:
          (json["ricercatore_a_tempo_indeterminato"] as List)
              .map((e) => AcademicStaffYearData.fromJson(e))
              .toList(),
      fixedTermResearchers:
          (json["ricercatore_a_tempo_determinato"] as List)
              .map((e) => AcademicStaffYearData.fromJson(e))
              .toList(),
    );
  }
}

class AcademicStaffYearData {
  final String year;
  final int fullTime;
  final int partTime;

  AcademicStaffYearData({
    required this.year,
    required this.fullTime,
    required this.partTime,
  });

  factory AcademicStaffYearData.fromJson(Map<String, dynamic> json) {
    return AcademicStaffYearData(
      year: json["anno"],
      fullTime: json["tempo_pieno"],
      partTime: json["tempo_definito"],
    );
  }
}

class AdministrativeStaffByYear {
  final List<AdministrativeStaffYearData> yearlyData;

  AdministrativeStaffByYear({required this.yearlyData});

  factory AdministrativeStaffByYear.fromJson(List<dynamic> json) {
    return AdministrativeStaffByYear(
      yearlyData:
          json.map((e) => AdministrativeStaffYearData.fromJson(e)).toList(),
    );
  }
}

class AdministrativeStaffYearData {
  final String year;
  final int fullTime;
  final int partTime;
  final int total;

  AdministrativeStaffYearData({
    required this.year,
    required this.fullTime,
    required this.partTime,
    required this.total,
  });

  factory AdministrativeStaffYearData.fromJson(Map<String, dynamic> json) {
    return AdministrativeStaffYearData(
      year: json["anno"],
      fullTime: json["full_time"],
      partTime: json["part_time"],
      total: json["totale"],
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
