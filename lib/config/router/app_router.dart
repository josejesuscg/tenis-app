import 'package:go_router/go_router.dart';
import 'package:tenis_app/feature/auth/presentation/screens/login_screen.dart';
import 'package:tenis_app/feature/auth/presentation/screens/main_screen.dart';
import 'package:tenis_app/feature/auth/presentation/screens/register_screen.dart';
import 'package:tenis_app/feature/bottom_navigation_bar.dart';
import 'package:tenis_app/feature/favorities/presentation/screens/favorites_screen.dart';
import 'package:tenis_app/feature/home/presentation/screens/home_screen.dart';
import 'package:tenis_app/feature/home/presentation/screens/reservation_screen.dart';
import 'package:tenis_app/feature/reservation/presentation/screens/reservations_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: MainScreen.name,
    builder: (context, state) => const MainScreen(),
  ),
   GoRoute(
     path: '/login_screen',
     name: LoginScreen.name,
     builder: (context, state) => LoginScreen(),
   ),
    GoRoute(
     path: '/register_screen',
     name: RegisterScreen.name,
     builder: (context, state) => RegisterScreen(),
   ),
     GoRoute(
     path: '/bottom_nav_bar',
     name: BottomBarTenisApp.name,
     builder: (context, state) => BottomBarTenisApp(),
   ),
      GoRoute(
     path: '/home_screen',
     name: HomeScreen.name,
     builder: (context, state) => HomeScreen(),
   ),
      GoRoute(
     path: '/reservations_screen',
     name: ReservationsScreen.name,
     builder: (context, state) => ReservationsScreen(),
   ),
       GoRoute(
     path: '/favorites_screen',
     name: FavoritesScreen.name,
     builder: (context, state) => FavoritesScreen(),
   ),



]);
