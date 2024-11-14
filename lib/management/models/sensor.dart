class Sensor {
  final int id;
  final double gasValue;
  final double temp;
  final bool safe;
  final bool unsafe;

  Sensor({
    required this.id,
    required this.gasValue,
    required this.temp,
    required this.safe,
    required this.unsafe,
  });

  // Factory method to create a Sensor instance from JSON
  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      id: json['id'],
      gasValue: json['gasValue'].toDouble(),
      temp: json['temp'].toDouble(),
      safe: json['safe'],
      unsafe: json['unsafe'],
    );
  }
}
