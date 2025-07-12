class ValueWithUnit {
  final num value;
  final String unitOfMeasure;

  ValueWithUnit({required this.value, required this.unitOfMeasure});

  factory ValueWithUnit.fromJson(Map<String, dynamic> json) {
    return ValueWithUnit(
      value: json["valore"],
      unitOfMeasure: json["unita_di_misura"],
    );
  }
}
