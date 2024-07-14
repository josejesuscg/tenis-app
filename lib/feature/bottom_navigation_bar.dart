import 'package:flutter/material.dart';
import 'package:tenis_app/feature/favorities/presentation/screens/favorites_screen.dart';
import 'package:tenis_app/feature/home/presentation/screens/home_screen.dart';
import 'package:tenis_app/feature/reservation/presentation/screens/reservations_screen.dart';

class BottomBarTenisApp extends StatefulWidget {

  static const name = 'bottom_nav_bar';

  const BottomBarTenisApp({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarTenisAppState createState() => _BottomNavigationBarTenisAppState();
}

class _BottomNavigationBarTenisAppState extends State<BottomBarTenisApp> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    ReservationsScreen(),
    const FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reservas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
