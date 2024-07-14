import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tenis_app/feature/auth/presentation/screens/login_screen.dart';
import 'package:tenis_app/feature/auth/presentation/widgets/ClipperPathLoginWidget.dart';
import 'package:tenis_app/feature/auth/presentation/widgets/PasswordFieldWidget.dart';
import 'package:tenis_app/feature/auth/presentation/widgets/TextFieldWidget.dart';

class RegisterScreen extends StatefulWidget {
  static const name = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true; 
      });
      try {
        
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
        });

        await Future.delayed(Duration(seconds: 2));

       
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        setState(() {
          _isLoading = false; 
        });

        
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _isLoading = false; 
        });

        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al registrar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/tenis_auth.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registro',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Divider(color: Colors.blue, endIndent: 320),
                    SizedBox(height: 16),
                    buildTextField('Nombre y apellido', Icons.person, _nameController, TextInputType.name),
                    buildTextField('Email', Icons.email, _emailController, TextInputType.emailAddress),
                    buildTextField('Teléfono', Icons.phone, _phoneController,TextInputType.phone),
                    buildPasswordField('Contraseña', Icons.lock, _passwordController),
                    buildPasswordField('Confirmar contraseña', Icons.lock, _confirmPasswordController),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white) 
                            : Text(
                                'Registrarme',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                      ),
                    ),
                           SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Lógica para registrarse
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Ya tengo cuenta  ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Iniciar sesión',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget buildTextField(String labelText, IconData icon, TextEditingController controller, TextInputType keyboardType) {
  return CustomTextField(
    labelText: labelText,
    icon: icon,
    controller: controller,
    keyboardType: keyboardType,
  );
}



Widget buildPasswordField(String labelText, IconData icon, TextEditingController controller) {
  return PasswordField(
    labelText: labelText,
    icon: icon,
    controller: controller,
  );
}


}

