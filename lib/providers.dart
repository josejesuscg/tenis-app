
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tenis_app/di/injection_container.dart';
import 'package:tenis_app/feature/auth/presentation/providers/auth_provider.dart';
import 'package:tenis_app/feature/auth/presentation/providers/user_provider.dart';
import 'package:tenis_app/feature/favorities/presentation/providers/favorities_provider.dart';
import 'package:tenis_app/feature/reservation/presentation/providers/reservation_provider.dart';


class Providers {
  static List<SingleChildWidget>  list = [
      ListenableProvider<AuthenticationProvider>(create: (_) => sl<AuthenticationProvider>()),
      ListenableProvider<UserStateProvider>(create: (_) => sl<UserStateProvider>()),
      ListenableProvider<ReservationsProvider>(create: (_) => sl<ReservationsProvider>()),
      ListenableProvider<FavoriteProvider>(create: (_) => sl<FavoriteProvider>())
  ];
}