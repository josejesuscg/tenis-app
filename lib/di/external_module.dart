
import 'package:get_it/get_it.dart';
import 'package:tenis_app/feature/reservation/data/local/db_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

initExternal(GetIt sl) async {
  final dataBase = await DatabaseProvider.db.initDB();


   sl.registerLazySingleton(() => dataBase);


}
