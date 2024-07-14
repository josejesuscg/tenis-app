import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/feature/bottom_navigation_bar.dart';
import 'package:tenis_app/feature/home/domain/models/court_model.dart';
import 'package:tenis_app/feature/reservation/data/local/db_provider.dart';
import 'package:tenis_app/feature/reservation/domain/models/reservation_model.dart';
import 'package:tenis_app/feature/reservation/presentation/providers/reservation_provider.dart';

class PreviewPaymentScreen extends StatefulWidget {
  static const name = 'preview_payment_screen';

  final Court court;
  final DateTime selectedDate;
  final TimeOfDay selectedStartTime;
  final TimeOfDay selectedEndTime;
  final String selectedInstructor;
  final String comment;
  late double totalToPay;

  PreviewPaymentScreen({
    super.key,
    required this.court,
    required this.selectedDate,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.selectedInstructor,
    required this.comment,
  });

  @override
  State<PreviewPaymentScreen> createState() => _PreviewPaymentScreenState();

 
  
}
 

class _PreviewPaymentScreenState extends State<PreviewPaymentScreen> {

late double totalToPay;


   @override
  void initState() {
    super.initState();
    totalToPay = _calculateTotalToPay();
  }

   double _calculateTotalToPay() {
    final startTime = TimeOfDay(
      hour: widget.selectedStartTime.hour,
      minute: widget.selectedStartTime.minute,
    );
    final endTime = TimeOfDay(
      hour: widget.selectedEndTime.hour,
      minute: widget.selectedEndTime.minute,
    );

    final startDateTime = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      startTime.hour,
      startTime.minute,
    );

       final endDateTime = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
      widget.selectedDate.day,
      endTime.hour,
      endTime.minute,
    );

    final differenceInHours = endDateTime.difference(startDateTime).inHours;
    double precio = double.parse(widget.court.precio);
    double total = precio * differenceInHours;
    return total;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.court.imageUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Positioned(
                  top: 50,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 16,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.court.title,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(widget.court.type,
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('\$${widget.court.precio}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Text('Por hora',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.blue, size: 16),
                      SizedBox(width: 8),
                      Text(widget.court.status, style: TextStyle(fontSize: 16)),
                      SizedBox(width: 16),
                      Icon(Icons.schedule, color: Colors.grey, size: 16),
                      SizedBox(width: 8),
                      Text(widget.court.time, style: TextStyle(fontSize: 16)),
                      SizedBox(width: 16),
                      Icon(Icons.cloud, color: Colors.grey, size: 16),
                      SizedBox(width: 8),
                      Text('30%', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 16),
                      SizedBox(width: 8),
                      Text(widget.court.direccion,
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Resumen',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.sports_tennis, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(widget.court.type, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(DateFormat('dd/MM/yyyy').format(widget.selectedDate),
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(widget.selectedInstructor,
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                          '${widget.selectedStartTime.format(context)} - ${widget.selectedEndTime.format(context)}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Total a pagar',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('\$$totalToPay'.toString(),
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Text('Por ${widget.selectedEndTime.hour - widget.selectedStartTime.hour} horas',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            // onPrimary: Colors.blue,
                            side: BorderSide(color: Colors.green),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                          ),
                          child: Text('Reprogramar reserva',
                              style: TextStyle(fontSize: 18)),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            Reservation reservation = Reservation(
                              title: widget.court.title,
                              date: DateFormat('dd/MM/yyyy')
                                  .format(widget.selectedDate),
                              user:
                                  'Usuario', 
                              imageUrl: widget.court.imageUrl,
                              price: totalToPay.toString(),
                              instructor: widget.selectedInstructor,
                              time: (widget.selectedEndTime.hour - widget.selectedStartTime.hour)
                            );

                            await DatabaseProvider.db.initDB();

                            // Añadir reserva usando el provider
                            bool reservationAdded =
                                await Provider.of<ReservationsProvider>(context,
                                        listen: false)
                                    .addReservation(reservation);

                            if (reservationAdded) {
                              // Navegar de vuelta a la pantalla de inicio
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomBarTenisApp()),
                              );
                            } else {
                              // Mostrar el diálogo de alerta si la reserva no fue añadida
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Cancha no disponible"),
                                    content: Text(
                                        "La cancha no está disponible para este día."),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                          ),
                          child: Text('Pagar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomBarTenisApp()),
                              );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                          ),
                          child: Text('Cancelar',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
