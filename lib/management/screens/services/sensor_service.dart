import 'dart:convert';
import 'package:fastflow_app/management/models/sensor.dart';
import 'package:http/http.dart' as http;

class SensorsService {
  final String baseUrl = 'https://safe-flow-api.sfo1.zeabur.app/api/safeflow/v1/sensors';

  Future<List<Sensor>> getAllSensors() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Sensor.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load sensors');
    }
  }
}
