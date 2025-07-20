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
