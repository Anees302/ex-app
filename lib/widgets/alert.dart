import 'package:expense/screens/screens.dart';
import 'package:flutter/material.dart';

Widget dialogBuilder(BuildContext context) {
  return AlertDialog(
    title: const Text('Verify Email First'),
    content: const Text(
        'Please verify your email before you register to the Expense manager application'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const OtpScreen()));
        },
        child: const Text('Verify Email'),
      )
    ],
  );
}
