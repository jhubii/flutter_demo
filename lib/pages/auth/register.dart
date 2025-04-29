import 'package:firebase_demo/components/inputField.dart';
import 'package:firebase_demo/pages/auth/login.dart';
import 'package:firebase_demo/services/authService.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/images/registerbackground.png',
                fit: BoxFit.cover,
              ),
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const Text('Register your new account'),
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
                inputController: usernameController,
                isPassword: false,
                label: 'Username',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
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
              InputField(
                inputController: confirmPasswordController,
                isPassword: true,
                label: 'Confirm Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
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
                    final user = await _authService.register(
                      email: emailController.text,
                      password: passwordController.text,
                      username: usernameController.text,
                    );
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Registration failed. Please try again.',
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: const Text('Already have an account? Please login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
