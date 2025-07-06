double parsePercentage(String raw) {
  final normalized = raw.replaceAll("%", "").replaceAll(",", ".").trim();
  return double.tryParse(normalized) ?? 0.0;
}
