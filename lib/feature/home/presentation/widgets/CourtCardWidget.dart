import 'package:flutter/material.dart';
import 'package:tenis_app/feature/home/domain/models/court_model.dart';
import 'package:tenis_app/feature/home/presentation/screens/reservation_screen.dart';

class BuildCourtCard extends StatelessWidget {
  const BuildCourtCard({
    super.key,
    required this.context,
    required this.court,
  });

  final BuildContext context;
  final Court court;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      child: Card(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(court.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8), bottom: Radius.circular(8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(court.title,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(court.type, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(court.date, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                          court.status == 'Disponible'
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 14,
                          color: court.status == 'Disponible'
                              ? Colors.green
                              : Colors.red),
                      const SizedBox(width: 4),
                      Text(court.status, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(width: 8),
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(court.time, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegar a la pagina de reservas, pasando los datos de la cancha
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CourtDetailsScreen(court: court)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      ),
                      child: const Text('Reservar',
                          style: TextStyle(color: Colors.white)),
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
