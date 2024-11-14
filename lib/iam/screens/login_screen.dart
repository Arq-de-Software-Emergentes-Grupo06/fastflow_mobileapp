import 'dart:convert';
import 'package:fastflow_app/iam/services/iam_service.dart';
import 'package:flutter/material.dart';
import 'package:fastflow_app/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final response = await _authService.signIn(
      _usernameController.text,
      _passwordController.text,
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    // Verificamos si la respuesta contiene el mensaje "Login successful"
    if (response.statusCode == 202 || response.body.contains("Login successful")) {
      // Usamos el username de los campos, ya que el servidor no lo devuelve.
      final userName = _usernameController.text;
      final userEmail = ""; // Puedes asignar un valor real o dejarlo en blanco si no está disponible.

      // Navegación a MainScreen con los datos del usuario
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            userName: userName,
            userEmail: userEmail,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(_usernameController, 'Username', Icons.person),
                const SizedBox(height: 16.0),
                _buildTextField(_passwordController, 'Password', Icons.lock, obscureText: true),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
