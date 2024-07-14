import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/config/router/app_router.dart';
import 'package:tenis_app/config/theme/theme.dart';
import 'package:tenis_app/providers.dart';
import '../../../../../di/injection_container.dart' as di;
// Import the generated file

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await di.init();
  await Firebase.initializeApp(
    options: FirebaseOptions(
    apiKey: 'AIzaSyAw5PyOKRAahYNWjGRpYt0tubaeI6SJkE4',
    appId: '1:715068082068:android:8f45079474f019df00b181',
    messagingSenderId: '715068082068',
    projectId: 'tenis-app-a2b03',
    storageBucket: 'tenis-app-a2b03.appspot.com'
  )
    // options: DefaultFirebaseOptions.currentPlatform
);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.list,
      child: MaterialApp.router(
        theme: getThemeData(),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}