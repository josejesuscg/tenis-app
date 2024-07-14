
import 'package:flutter/material.dart';

class UserStateProvider extends ChangeNotifier {
  // AuthProvider({required this.loginUseCase});

  // final LoginUseCase loginUseCase;

  String? _userName;

  String? get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();  
  }
}
