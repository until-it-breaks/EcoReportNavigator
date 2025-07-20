class ActiveCourse {
  final String name;
  final List<YearlyCourseData> yearlyInfo;

  ActiveCourse({required this.name, required this.yearlyInfo});

  factory ActiveCourse.fromJson(Map<String, dynamic> json) {
    return ActiveCourse(
      name: json["nome"],
      yearlyInfo:
          (json["anni"] as List)
              .map((e) => YearlyCourseData.fromJson(e))
              .toList(),
    );
  }

  static List<ActiveCourse> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => ActiveCourse.fromJson(item)).toList();
  }
}

class YearlyCourseData {
  final String year;
  final int amount;

  YearlyCourseData({required this.year, required this.amount});

  factory YearlyCourseData.fromJson(Map<String, dynamic> json) {
    return YearlyCourseData(year: json["anno"], amount: json["valore"]);
  }
}
