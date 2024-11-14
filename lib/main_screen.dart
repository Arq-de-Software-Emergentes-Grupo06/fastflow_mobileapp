import 'package:fastflow_app/iam/profile_screen.dart';
import 'package:fastflow_app/incidents/screens/incident_list_screen.dart';
import 'package:fastflow_app/management/screens/servicios_list.dart';
import 'package:flutter/material.dart';
import 'package:fastflow_app/management/screens/deliveries_list_screen.dart';
import 'package:fastflow_app/shared/bottom_navigation_bar.dart';


class MainScreen extends StatefulWidget {
  final String userName; // Agrega este parámetro
  final String userEmail; // Agrega este parámetro

  const MainScreen({
    super.key, 
    required this.userName, // Requerido en el constructor
    required this.userEmail, // Requerido en el constructor
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      ServiciosListScreen(),
      DeliveriesListScreen(),
      IncidentsListScreen(),
      // Pasa los datos de usuario a ProfileScreen
      ProfileScreen(userName: widget.userName, userEmail: widget.userEmail), 
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
