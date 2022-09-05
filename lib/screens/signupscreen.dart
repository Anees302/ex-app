// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:expense/widgets/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String? mailRecieved;
TextEditingController? _emailController;

// ignore: must_be_immutable
class SignupScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  SignupScreen(
    this.mail,
  ) {
    mailRecieved = mail;
  }
  static const routeName = '/signup';
  final String mail;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    _emailController = TextEditingController(text: mailRecieved);
    super.initState();
  }

  final _passwordController = TextEditingController();

  final _userNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // bool _isOtpVerified = verified;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 205, 211),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(
                  child: Text('Register',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 90,
                          color: Colors.blue)),
                ),
              ),
              TextField(
                enabled: false,
                controller: _emailController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email_outlined,
                    ),
                    hintText: 'Email'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _userNameController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person_outlined,
                    ),
                    hintText: 'Username'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.note_alt,
                    ),
                    hintText: 'Address'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _contactController,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.call,
                    ),
                    hintText: 'Contact'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    child: const Text('Signup'),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Already Registered'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: _emailController!.value.text.trim(),
        password: _passwordController.value.text.trim());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user?.uid)
        .set({
      'username': _userNameController.value.text,
      'email': _emailController!.value.text,
      'contact': _contactController.value.text,
      'Address': _addressController.value.text
    });
  }
}
