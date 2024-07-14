import 'package:get_it/get_it.dart';
import 'package:tenis_app/feature/favorities/presentation/providers/favorities_provider.dart';


initProvider(GetIt sl) {
  sl.registerFactory(
    () => FavoriteProvider(),
  );

}
