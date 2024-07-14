import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;

  const PasswordField({
    Key? key,
    required this.labelText,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Container(
            height: 10,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon),
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
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
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
            return 'Por favor ingrese ${widget.labelText}';
          }
          return null;
        },
      ),
    );
  }
}