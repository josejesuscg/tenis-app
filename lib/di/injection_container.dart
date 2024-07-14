
import 'package:get_it/get_it.dart';
import 'package:tenis_app/feature/auth/di/auth_module.dart';
import 'package:tenis_app/feature/favorities/di/favorites_module.dart';
import 'package:tenis_app/feature/reservation/di/reservations_module.dart';

import 'external_module.dart';

final sl = GetIt.instance;

init() async {
  await initExternal(sl);


  initAuthModule(sl);
  initFavoritesModule(sl);
  initReservationsModule(sl);
}
