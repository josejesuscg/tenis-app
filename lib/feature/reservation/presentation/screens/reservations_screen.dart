import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/feature/auth/presentation/providers/user_provider.dart';
import 'package:tenis_app/feature/home/presentation/widgets/ReservationCardWidget.dart';
import 'package:tenis_app/feature/reservation/data/local/db_provider.dart';
import 'package:tenis_app/feature/reservation/domain/models/reservation_model.dart';
import 'package:tenis_app/feature/reservation/presentation/providers/reservation_provider.dart';

class ReservationsScreen extends StatefulWidget {
  static const name = 'reservations_screen';

  ReservationsScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {

//  final GlobalKey<ScaffoldState> scaffoldKeyReserv = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    
     String userName = Provider.of<UserStateProvider>(context).userName ?? 'Usuario';

    return Scaffold(
        // key: scaffoldKeyReserv,
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

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción para programar reserva
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Background color
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.add, color: Colors.white,),
                          SizedBox(width: 5),
                            Text('Programar reserva', style:TextStyle(color: Colors.white, fontSize: 24),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Mis reservas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: 
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
                        print('ID en home: ${reservation.id}');
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
                      child: ResevationCardWidget(context: context, title: reservation.title, date: reservation.date, user: userName, imageUrl: reservation.imageUrl, price: reservation.price!, time: reservation.time!,),
                    );
                  },
                )
                : Center(child: Text('No hay reservas disponibles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),))
                    ),
                  ],
                ),
              );
            }),
      
        );
  }
}
