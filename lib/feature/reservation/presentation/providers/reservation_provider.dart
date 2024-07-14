import 'package:flutter/material.dart';
import 'package:tenis_app/feature/reservation/data/local/db_provider.dart';
import 'package:tenis_app/feature/reservation/domain/models/reservation_model.dart';


class ReservationsProvider extends ChangeNotifier {
  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  Future<void> loadReservations() async {
    _reservations = await DatabaseProvider.db.getReservations();
    notifyListeners();
  }

Future<bool> addReservation(Reservation reservation) async {
    bool isAvailable = await checkCourtAvailability(reservation.title, reservation.date);
    if (isAvailable) {
      int id = await DatabaseProvider.db.addReservation(reservation);
      if (id > 0) {
        reservation.id = id;
        _reservations.add(reservation);
        notifyListeners();
        return true;
      }
    }
    return false;
  }
  Future<void> deleteReservation(int id) async {
    print('ESTE ES EL ID EN PROVIDER: $id');
    await DatabaseProvider.db.deleteReservation(id);
    _reservations.removeWhere((reservation) => reservation.id == id);
    notifyListeners();
  }

    Future<bool> checkCourtAvailability(String title, String date) async {
    List<Reservation> allReservations = await DatabaseProvider.db.getReservations();
    int count = allReservations.where((r) => r.title == title && r.date == date).length;
    return count < 2;
  }

  
}
