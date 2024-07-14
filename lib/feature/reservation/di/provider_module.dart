import 'package:get_it/get_it.dart';
import 'package:tenis_app/feature/reservation/presentation/providers/reservation_provider.dart';




initProvider(GetIt sl) {
  sl.registerFactory(
    () => ReservationsProvider(),
  );

}
