import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fastflow_app/management/models/sensor.dart';
import 'package:fastflow_app/management/screens/services/sensor_service.dart';

class SensorsListScreen extends StatefulWidget {
  const SensorsListScreen({super.key});

  @override
  _SensorsListScreenState createState() => _SensorsListScreenState();
}

class _SensorsListScreenState extends State<SensorsListScreen> {
  final SensorsService _sensorsService = SensorsService();
  List<Sensor> _sensors = [];
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchSensors();

    // Configura la actualización automática de sensores cada 10 segundos
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _fetchSensors();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador cuando la pantalla se destruye
    super.dispose();
  }

  Future<void> _fetchSensors() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Sensor> sensors = await _sensorsService.getAllSensors();
      setState(() {
        _sensors = sensors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load sensors')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors Monitoring'),
        backgroundColor: Colors.orange.shade800,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Imagen de encabezado con padding para evitar que se corte
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.asset(
                    'assets/sensor.png',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.contain, // Usa BoxFit.contain para mantener la imagen completa
                  ),
                ),
                const SizedBox(height: 16), // Espacio entre la imagen y la lista
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _sensors.length,
                    itemBuilder: (context, index) {
                      return _buildSensorCard(_sensors[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSensorCard(Sensor sensor) {
    return Card(
      color: Colors.orange.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icono de seguridad
            Image.asset(
              sensor.safe ? 'assets/safe.png' : 'assets/warn.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 16),
            // Información del sensor
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sensor ID: ${sensor.id}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gas Value: ${sensor.gasValue.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Temperature: ${sensor.temp.toStringAsFixed(2)}°C',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),
            // Indicador de seguridad
            Text(
              sensor.safe ? 'SAFE' : 'UNSAFE',
              style: TextStyle(
                color: sensor.safe ? Colors.green.shade800 : Colors.red.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
