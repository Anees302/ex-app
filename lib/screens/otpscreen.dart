import 'package:email_auth/email_auth.dart';
import 'package:expense/screens/screens.dart';
import 'package:flutter/material.dart';

bool _result = false;

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);
  static const routeName = '/otpscreen';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  EmailAuth emailAuth = EmailAuth(sessionName: "OTP for Expense App");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  var isVerified = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 205, 211),
      appBar: AppBar(
        title: const Text('Verify Email'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: const Center(
                child: Icon(
                  Icons.message_outlined,
                  size: 180,
                ),
              ),
            ),
            Stack(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email_outlined), hintText: 'Email'),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () => sendOtp(),
                        child: const Text('send otp')))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.verified_user_outlined), hintText: 'OTP'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () {
                  verifyOtp();
                  if (_result) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) =>
                            SignupScreen(_emailController.value.text))));
                  }
                },
                child: const Text('Validate OTP'))
          ],
        ),
      ),
    );
  }

  void sendOtp() async {
    print(_emailController.value.text);
    bool status = await emailAuth.sendOtp(
      recipientMail: _emailController.value.text.trim(),
    );
    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Otp Sent'),
        ),
      );
    }
  }

  void verifyOtp() async {
    _result = await emailAuth.validateOtp(
        recipientMail: _emailController.value.text,
        userOtp: _otpController.value.text);
    if (_result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Otp verified'),
        ),
      );
    }
  }
}
