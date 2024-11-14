import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://safe-flow-api.sfo1.zeabur.app/api/v1/auth';

  Future<http.Response> signIn(String username, String password) async {
    final url = Uri.parse('$baseUrl/signin');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );
  }

  Future<http.Response> signUp(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/signup');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'email': email, 'password': password}),
    );
  }
}
