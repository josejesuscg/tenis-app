

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tenis_app/feature/auth/presentation/providers/user_provider.dart';
import 'package:tenis_app/feature/auth/presentation/screens/main_screen.dart';
import 'package:tenis_app/feature/home/domain/models/court_model.dart';
import 'package:tenis_app/feature/home/presentation/widgets/CourtCardWidget.dart';
import 'package:tenis_app/feature/home/presentation/widgets/ReservationCardWidget.dart';
import 'package:tenis_app/feature/reservation/data/local/db_provider.dart';
import 'package:tenis_app/feature/reservation/domain/models/reservation_model.dart';
import 'package:tenis_app/feature/reservation/presentation/providers/reservation_provider.dart';


class HomeScreen extends StatefulWidget {
  static const name = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();

List<Reservation> reservations = [

];



class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    String userName =
        Provider.of<UserStateProvider>(context).userName ?? 'Usuario';

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Text(
            'Tennis',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            ' court',
            style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        CircleAvatar(
          backgroundImage:
              AssetImage('assets/images/user.jpg'), // Imagen del usuario
        ),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.black),
          onPressed: () {
            
          },
        ),
        Builder(
          builder: (BuildContext context) {
           return IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              Scaffold.of(context).openEndDrawer();
            },
          );
          } 
        ),
        SizedBox(width: 16),
      ],
      
    ),
        body: FutureBuilder<List<Reservation>>(
            future: DatabaseProvider.db.getReservations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              List<Reservation> reservations = snapshot.data ?? [];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Hola $userName!',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Canchas',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                CarouselSlider(
                  options: CarouselOptions(
                      height: 400,
                      // viewportFraction: 0.6,
                      padEnds: false,
                      enableInfiniteScroll: false),
                  items: courts.map((court) {
                    return BuildCourtCard(context: context, court: court);
                  }).toList(),
                ),
                SizedBox(height: 32),
                Text(
                  'Reservas programadas',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                reservations.isNotEmpty 
                ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    var reservation = reservations[index];
                    return Dismissible(
                      key: Key(reservation.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: AlignmentDirectional.centerEnd,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmar"),
                              content: Text(
                                  "¿Estás seguro de que deseas eliminar esta reservación?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text("Eliminar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) async {
                        if (reservation.id != null) {
                          await Provider.of<ReservationsProvider>(context,
                                  listen: false)
                              .deleteReservation(reservation.id!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Reservación eliminada"),
                            ),
                          );
                          setState(() {});
                        }
                      },
                      child: ResevationCardWidget(
                        context: context, 
                        title: reservation.title, 
                        date: reservation.date, 
                        user: userName, 
                        imageUrl: 
                        reservation.imageUrl, 
                        price: reservation.price!, 
                        time: reservation.time!,),
                    );
                  },
                )
                : Text('No hay reservas disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
              ]),
            ),
          );
        }),
         endDrawer: Drawer(
            // Contenido del Drawer
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text(
                    'Tenis Court App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Cerrar sesión'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()), (route) => route.isFirst);
                  },
                ),
      
      ]))),
    );
  }
}



List<Court> courts = [
  Court('Epic Box', 'Cancha tipo A', '9 de julio 2024', 'Disponible',
      '7:00 am a 4:00 pm', 'assets/images/cancha-a.jpg', '20', 'Av Caracas'),
  Court('Sport Box', 'Cancha tipo B', '10 de julio 2024', 'No disponible',
      'N/A', 'assets/images/cancha-B.jpg', '25', 'Av Merida'),
  Court('Cancha multiple', 'Cancha tipo C', '12 de julio 2024', 'Disponible',
      '9:00 am a 7:00 pm', 'assets/images/cancha-C.jpg', '30', 'Av Zulia'),
  
];


