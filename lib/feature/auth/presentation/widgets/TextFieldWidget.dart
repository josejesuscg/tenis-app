import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    required this.controller,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Container(
            height: 10,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                VerticalDivider(
                  endIndent: 10,
                  indent: 10,
                  color: Colors.black,
                  thickness: 1,
                  width: 10,
                ),
              ],
            ),
          ),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.zero,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.zero,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.zero,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $labelText';
          }
          return null;
        },
      ),
    );
  }
}
