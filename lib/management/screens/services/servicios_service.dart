import 'dart:convert';
import 'dart:io';

//import 'package:ayni_flutter_app/home_screens/models/products.dart';
import 'package:fastflow_app/management/models/servicios.dart';
import 'package:http/http.dart' as http;

class ServiciosService {
  final String baseUrl = "https://my-json-server.typicode.com/JorgeGonzales15/ayni-jsonplaceholder-iot/products";

  Future<List<Servicios>> getAll() async {
    final http.Response response = await http.get(Uri.parse(baseUrl));

     if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey("results")) {
        final List<dynamic> maps = jsonResponse["results"];

        return maps.map((map) => Servicios.fromJson(map)).toList();
      } else if (jsonResponse is List<dynamic>) {
        return jsonResponse.map((map) => Servicios.fromJson(map)).toList();
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load products');
    }
  
  }

  Future<List<Servicios>> getByName(String name) async {
    final http.Response response = await http.get(Uri.parse('$baseUrl?name="$name"'));

     if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey("results")) {
        final List<dynamic> maps = jsonResponse["results"];

        return maps.map((map) => Servicios.fromJson(map)).toList();
      } else if (jsonResponse is List<dynamic>) {
        return jsonResponse.map((map) => Servicios.fromJson(map)).toList();
      } else {
        throw Exception('ProductService Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}