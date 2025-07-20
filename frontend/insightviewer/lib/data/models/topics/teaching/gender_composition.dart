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
