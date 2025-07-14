class Section {
  final int id;
  final String name;
  final int startPage;
  final Map<String, dynamic> data;

  Section({
    required this.id,
    required this.name,
    required this.startPage,
    required this.data,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    final rawData = json["data"] as Map<String, dynamic>;

    return Section(
      id: json["numero"],
      name: json["nome"],
      startPage: json["pagina"],
      data: rawData,
    );
  }
}
