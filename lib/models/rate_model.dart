class RateModel {
  final double rate;
  final int count;

  RateModel({
    required this.rate,
    required this.count,
  });

  factory RateModel.fromJson(Map<String, dynamic> jsonData) {
    return RateModel(
      rate: (jsonData['rate'] as num).toDouble(),
      count: jsonData['count'],
    );
  }
}
