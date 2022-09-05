import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    // String? userName;
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user?.uid)
    //     .get()
    //     .then((snapshot) => snapshot.docs);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Expense App'),
      ),
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
        builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading....');
          }
          return Text(snapshot.data!['username']);
        }),
      ),
    );
  }
}
