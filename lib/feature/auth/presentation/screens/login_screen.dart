import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenis_app/feature/auth/presentation/providers/user_provider.dart';
import 'package:tenis_app/feature/auth/presentation/screens/register_screen.dart';
import 'package:tenis_app/feature/auth/presentation/widgets/ClipperPathLoginWidget.dart';
import 'package:tenis_app/feature/auth/presentation/widgets/PasswordFieldWidget.dart';
import 'package:tenis_app/feature/auth/presentation/widgets/TextFieldWidget.dart';
import 'package:tenis_app/feature/bottom_navigation_bar.dart';

class LoginScreen extends StatefulWidget {
  static const name = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false; 
  final String userName = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                        image: AssetImage(
                            'assets/images/tenis_auth.jpg'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.blue,
                    endIndent: 320,
                  ),
                  SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextField(
                          'Email',
                          Icons.email,
                          _emailController,
                          TextInputType.emailAddress,
                        ),
                        buildPasswordField(
                          'Contraseña',
                          Icons.lock,
                          _passwordController,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                            Text('Recordar contraseña'),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              
                            },
                            child: Text(
                              '¿Olvidaste tu contraseña?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : () => _login(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator() 
                                : Text(
                                    'Iniciar sesión',
                                    style:
                                        TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Lógica para registrarse
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '¿Aún no tienes cuenta? ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Regístrate',
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
                ],
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

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential? credenciales = await login(
          context,
          _emailController.text,
          _passwordController.text,
        );
        if (credenciales != null) {
          if (credenciales.user != null) {
            
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomBarTenisApp(),
                ),
              );
          }
        }
      } catch (e) {
        print('Error al iniciar sesión: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al iniciar sesión: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false; 
        });
      }
    }
  }
}



// TODO Firebase Mover de aqui

Future<UserCredential?> login(BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

   
    DocumentSnapshot<Map<String, dynamic>> userInfo = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
    String userName = userInfo['name'];

    
    Provider.of<UserStateProvider>(context, listen: false).setUserName(userName);

    return userCredential;
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'Verifique su email';
    } else if (e.code == 'wrong-password') {
      message = 'Verifique su contraseña';
    } else {
      message = 'Error desconocido: ${e.message}';
    }

    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );

    return null;
  }
}
