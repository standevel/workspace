import 'package:flutter/material.dart';
import 'package:peersync/constants.dart';
import 'package:peersync/form/login.form.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  Future<String> _checkUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString(tokenName)!;
    return userToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('PeerSync'),
        // ),
        body: FutureBuilder<String>(
      future: _checkUserToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, '/dashboard');
            });
            return const Center(
              child: Text('Redirecting to dashboard...'),
            );
          } else {
            return Center(
                child: SizedBox(
              width: 400.0,
              height: 520.0,
              child: SingleChildScrollView(
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
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        const Text(
                          'Enter email and password',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white70),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LoginForm(
                            navigateToDashboard: () =>
                                {Navigator.pushNamed(context, '/dashboard')}),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/signup');
                          },
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Theme.of(context).shadowColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('No account? Sign up'),
                        ),
                        const SizedBox(
                          height: 12.0,
                        )
                      ],
                    )),
              ),
            ));
          }
        }
      },
    ));
  }
}
