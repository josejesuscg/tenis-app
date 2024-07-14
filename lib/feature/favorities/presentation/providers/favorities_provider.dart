import 'package:flutter/material.dart';
import 'package:tenis_app/feature/home/domain/models/court_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Court> _favoriteCourts = [];

  List<Court> get favoriteCourts => _favoriteCourts;

  void toggleFavorite(Court court) {
    if (_favoriteCourts.contains(court)) {
      _favoriteCourts.remove(court);
    } else {
      _favoriteCourts.add(court);
    }
    notifyListeners();
  }

  bool isFavorite(Court court) {
    return _favoriteCourts.contains(court);
  }
}
