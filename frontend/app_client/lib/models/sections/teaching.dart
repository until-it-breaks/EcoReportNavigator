class TeachingData {
  final TeachingSummary summary;
  final List<ActiveCourses> activeCourses;
  final EnrollmentByGender enrollmentByGender;
  final List<SdgsTeaching> sdgsTeachings;

  TeachingData({
    required this.summary,
    required this.activeCourses,
    required this.enrollmentByGender,
    required this.sdgsTeachings,
  });

  factory TeachingData.fromJson(Map<String, dynamic> json) {
    return TeachingData(
      summary: TeachingSummary.fromJson(
        json["didattica_e_comunita_studentesca"],
      ),
      activeCourses:
          (json["corsi_attivati"] as List)
              .map((e) => ActiveCourses.fromJson(e))
              .toList(),
      enrollmentByGender: EnrollmentByGender.fromJson(
        json["composizione_iscrizioni_per_genere"],
      ),
      sdgsTeachings:
          (json["insegnamenti_per_sdgs"] as List)
              .map((e) => SdgsTeaching.fromJson(e))
              .toList(),
    );
  }
}

class TeachingSummary {
  final int courseCount;
  final int enrolledStudents2023;
  final int internationalStudents;
  final int numberOfGraduates;
  final int ergoScholarships;
  final String onTimeEnrolledPercentage;

  TeachingSummary({
    required this.courseCount,
    required this.enrolledStudents2023,
    required this.internationalStudents,
    required this.numberOfGraduates,
    required this.ergoScholarships,
    required this.onTimeEnrolledPercentage,
  });

  factory TeachingSummary.fromJson(Map<String, dynamic> json) {
    return TeachingSummary(
      courseCount: json["corsi_di_studio"]["numero_corsi"],
      enrolledStudents2023: json["studenti_iscritti_2023"],
      internationalStudents: json["studenti_internazionali"],
      numberOfGraduates: json["numero_laureati"],
      ergoScholarships: json["borse_di_studio_ergo"],
      onTimeEnrolledPercentage: json["percentuale_iscritti_in_corso"],
    );
  }
}

class ActiveCourses {
  final String name;
  final List<YearlyCourseData> years;

  ActiveCourses({required this.name, required this.years});

  factory ActiveCourses.fromJson(Map<String, dynamic> json) {
    return ActiveCourses(
      name: json["nome"],
      years:
          (json["anni"] as List)
              .map((e) => YearlyCourseData.fromJson(e))
              .toList(),
    );
  }
}

class YearlyCourseData {
  final String year;
  final int value;

  YearlyCourseData({required this.year, required this.value});

  factory YearlyCourseData.fromJson(Map<String, dynamic> json) {
    return YearlyCourseData(year: json["anno"], value: json["valore"]);
  }
}

class GenderComposition {
  final String year;
  final String women;
  final String men;

  GenderComposition({
    required this.year,
    required this.women,
    required this.men,
  });

  factory GenderComposition.fromJson(Map<String, dynamic> json) {
    return GenderComposition(
      year: json["anno"],
      women: json["donne"],
      men: json["uomini"],
    );
  }
}

class EnrollmentByGender {
  final List<GenderComposition> stem;
  final List<GenderComposition> nonStem;
  final List<GenderComposition> total;

  EnrollmentByGender({
    required this.stem,
    required this.nonStem,
    required this.total,
  });

  factory EnrollmentByGender.fromJson(Map<String, dynamic> json) {
    return EnrollmentByGender(
      stem:
          (json["stem"] as List)
              .map((e) => GenderComposition.fromJson(e))
              .toList(),
      nonStem:
          (json["non_stem"] as List)
              .map((e) => GenderComposition.fromJson(e))
              .toList(),
      total:
          (json["totale"] as List)
              .map((e) => GenderComposition.fromJson(e))
              .toList(),
    );
  }
}

class SdgsTeaching {
  final String goal;
  final int courseCount;

  SdgsTeaching({required this.goal, required this.courseCount});

  factory SdgsTeaching.fromJson(Map<String, dynamic> json) {
    return SdgsTeaching(
      goal: json["goal"],
      courseCount: json["numero_insegnamenti"],
    );
  }
}
