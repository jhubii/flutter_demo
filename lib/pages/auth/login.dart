import 'package:firebase_demo/components/inputField.dart';
import 'package:firebase_demo/models/user.dart';
import 'package:firebase_demo/pages/auth/register.dart';
import 'package:firebase_demo/pages/main/home.dart';
import 'package:firebase_demo/services/authService.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/loginbackground.png',
                fit: BoxFit.cover,
              ),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const Text('Login your account'),
              InputField(
                inputController: emailController,
                isPassword: false,
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              InputField(
                inputController: passwordController,
                isPassword: true,
                label: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  backgroundColor: Color.fromARGB(255, 53, 97, 173),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final User? user = await _authService.login(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid email or password'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: const Text("Don't have an account? Please register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
