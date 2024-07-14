import 'package:get_it/get_it.dart';
import 'package:tenis_app/feature/auth/presentation/providers/user_provider.dart';



initProvider(GetIt sl) {
  sl.registerFactory(
    () => UserStateProvider(),
  );

}
