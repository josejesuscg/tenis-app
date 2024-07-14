import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/feature/favorities/presentation/providers/favorities_provider.dart';
import 'package:tenis_app/feature/home/domain/models/court_model.dart';
import 'package:tenis_app/feature/home/presentation/screens/preview_payment_screen.dart';

class CourtDetailsScreen extends StatefulWidget {
  static const name = 'cancha_details_screen';

  final Court court;

  const CourtDetailsScreen({Key? key, required this.court}) : super(key: key);

  @override
  _CourtDetailsScreenState createState() => _CourtDetailsScreenState();
}

class _CourtDetailsScreenState extends State<CourtDetailsScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String selectedInstructor = 'Seleccionar instructor';
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(widget.court);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(widget.court.imageUrl,
                        fit: BoxFit.cover, height: 200, width: double.infinity),
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
                      child: IconButton(
                        icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white),
                        onPressed: () {
                          favoriteProvider.toggleFavorite(widget.court);
                        },
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
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: Colors.blue, size: 16),
                          SizedBox(width: 8),
                          Text(widget.court.status,
                              style: TextStyle(fontSize: 16)),
                          SizedBox(width: 16),
                          Icon(Icons.schedule, color: Colors.grey, size: 16),
                          SizedBox(width: 8),
                          Text(widget.court.time,
                              style: TextStyle(fontSize: 16)),
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
                      DropdownButton<String>(
                        value: selectedInstructor,
                        items: <String>[
                          'Seleccionar instructor',
                          'Jose Martinez',
                          'Pedro Rodriguez',
                          'Saul Mata'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 18)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedInstructor = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 32),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Text('Establecer fecha y hora',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: DateFormat('dd/MM/yyyy')
                                              .format(selectedDate),
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Fecha',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          suffixIcon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _selectStartTime(context),
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: selectedStartTime
                                                  ?.format(context) ??
                                              '00:00',
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Hora de inicio',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          suffixIcon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _selectEndTime(context),
                                    child: AbsorbPointer(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: selectedEndTime
                                                  ?.format(context) ??
                                              '00:00',
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Hora de fin',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          suffixIcon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text('Agregar un comentario',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: commentController,
                              decoration: InputDecoration(
                                hintText: 'Agregar un comentario...',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                              ),
                              maxLines: 3,
                            ),
                            SizedBox(height: 32),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Acción para reservar
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PreviewPaymentScreen(
                                        court: widget
                                            .court, // Objeto Court de la cancha seleccionada
                                        selectedDate: selectedDate,
                                        selectedStartTime: selectedStartTime!,
                                        selectedEndTime: selectedEndTime!,
                                        selectedInstructor: selectedInstructor,
                                        comment: commentController.text,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 15),
                                ),
                                child: Text('Reservar',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
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
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedStartTime)
      setState(() {
        selectedStartTime = picked;
      });
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedEndTime)
      setState(() {
        selectedEndTime = picked;
      });
  }
}
