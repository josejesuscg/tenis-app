import 'package:flutter/material.dart';
class ResevationCardWidget extends StatelessWidget {
  const ResevationCardWidget({
    super.key,
    required this.context,
    required this.title,
    required this.date,
    required this.user,
    required this.imageUrl,
    required this.price, 
    required this.time,
  });

  final BuildContext context;
  final String title;
  final String date;
  final String user;
  final String imageUrl;
  final String price;
  final int time;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      child: ListTile(
        leading: Container(
          width: 60,
          height: 100,
          decoration: const BoxDecoration(
              // shape: BoxShape.values,
              ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                5), // Mitad del ancho/alto para hacerlo redondeado
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 14, color: Colors.grey),
                const SizedBox(width: 10),
                Text(date),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Reservado por: '),
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/user.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(user, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text('$time horas', style: const TextStyle(color: Colors.grey)),
                // SizedBox(width: 16),
                const VerticalDivider(),
                const Icon(Icons.attach_money, size: 14, color: Colors.grey),
                // SizedBox(width: 4),
                Text('$price', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}