import 'package:insightviewer/data/models/value_with_unit.dart';

class EnvironmentSummary {
  final ValueWithUnit photovoltaicSurface;
  final int environmentalCourses;
  final ValueWithUnit renewableEnergy;
  final int subsidizedSubscriptions;
  final ValueWithUnit subscriptionSpending;

  EnvironmentSummary({
    required this.photovoltaicSurface,
    required this.environmentalCourses,
    required this.renewableEnergy,
    required this.subsidizedSubscriptions,
    required this.subscriptionSpending,
  });

  factory EnvironmentSummary.fromJson(Map<String, dynamic> json) {
    return EnvironmentSummary(
      photovoltaicSurface: ValueWithUnit.fromJson(
        json["superficie_fotovoltaica"],
      ),
      environmentalCourses: json["insegnamenti_tematiche_ambientali"],
      renewableEnergy: ValueWithUnit.fromJson(
        json["energia_fonti_rinnovabili"],
      ),
      subsidizedSubscriptions: json["abbonamenti_agevolati"],
      subscriptionSpending: ValueWithUnit.fromJson(
        json["spesa_abbonamenti_agevolati"],
      ),
    );
  }
}
