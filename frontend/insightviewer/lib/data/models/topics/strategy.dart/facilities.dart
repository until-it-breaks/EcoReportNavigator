class Facilities {
  final int schoolAmount;
  final int departmentAmount;

  Facilities({required this.schoolAmount, required this.departmentAmount});

  factory Facilities.fromJson(Map<String, dynamic> json) {
    return Facilities(
      schoolAmount: json["scuole"],
      departmentAmount: json["dipartimenti"],
    );
  }
}
