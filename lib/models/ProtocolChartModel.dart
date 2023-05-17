class ProtocolChartModel {
  final double total;

  ProtocolChartModel({
    required this.total,
  });

  factory ProtocolChartModel.fromJson(Map<String, dynamic> json) {
    return ProtocolChartModel(
      total: json['total'],
    );
  }
}