import 'package:flutter/material.dart';
import 'package:peersync/form/user.form.dart';

class IndividualSignUpDesktopView extends StatelessWidget {
  const IndividualSignUpDesktopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 700,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(8.0), // Add rounded corners to the card
            ),
            color:
                Colors.blueGrey[800], // Darker color than the form background
            elevation: 12.0, // Add elevation to make the card stand out

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 2,
                  child: Image(
                    image: AssetImage('assets/images/fotor.jpg'),
                    fit: BoxFit.cover,
                    height: 550,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Hello, Welcome to PeerSync! First enter your name, work email and a password',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white70),
                        ),
                      ),
                      UserForm(
                        navigateToCreateWorkspace: () {
                          // Navigate to CreateWorkspacePage
                          Navigator.of(context).pushNamed('/create-workspace');
                        },
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
