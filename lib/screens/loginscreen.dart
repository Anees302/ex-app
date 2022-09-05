import 'package:expense/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/screens/signupscreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 205, 211),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(
                  child: Text('Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 90,
                          color: Colors.blue)),
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email_outlined), hintText: 'Email'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.key,
                    ),
                    hintText: 'Password'),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () => login(),
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const OtpScreen())),
                child: const Text('Sign up instead'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.value.text.trim(),
        password: _passwordController.value.text.trim());
  }
}
