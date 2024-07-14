import 'package:flutter/material.dart';


class AuthenticationProvider extends ChangeNotifier {

  // AuthProvider({required this.loginUseCase});

  // final LoginUseCase loginUseCase;

  // BaseState state = Initial();


  // Future<void> login(String email, String password) async {
  //   final params = LoginUseCaseParams(
  //     email: email,
  //     password: password
  //   );
  //   state = Loading();
  //   notifyListeners();
  //   final result = await loginUseCase(params);

  //   result.fold(
  //     (failure) => state = Error(failure: failure) ,
  //     (ok) => state = Loaded(value: ok),
  //   );
  //   notifyListeners();
  // }
}