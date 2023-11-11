import 'package:flutter/material.dart';
import 'package:peersync/form/forget_password.form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PeerSync'),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Expanded(
              child: SizedBox(
            width: 400.0,
            height: 500.0,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Add rounded corners to the card
                ),
                color: Colors
                    .blueGrey[800], // Darker color than the form background
                elevation: 12.0, // Add elevation to make the card stand out
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Forget Password',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const Text(
                      'Enter email and you will receive link to change your password',
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ForgetPasswordForm(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Theme.of(context).shadowColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Return to Login'),
                    ),
                  ],
                )),
          )),
        )));
  }
}
