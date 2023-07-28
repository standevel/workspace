import 'package:flutter/material.dart';
import 'package:peersync/constants.dart';
import 'package:peersync/form/company_signup.dart';

class CompanySignUpPage extends StatelessWidget {
  const CompanySignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint('view: $isMobileView');
    // debugPrint('view: ${const MediaQueryData().size.width}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('PeerSync'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              return ResponsiveUtils.isMobile(context)
                  ? const MobileView() // Render mobile-optimized view
                  : const DesktopView(); // Render desktop-optimized view
            },
          ),
        ),
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Add rounded corners to the card
          ),
          color: Colors.blueGrey[800], // Darker color than the form background
          elevation: 12.0, // Add elevation to make the card stand out

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('images/fotor.jpg'),
                fit: BoxFit.cover,
                height: 200,
                width: 400,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
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
                  const Text(
                    'Enter company name, work email and a password',
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.white70),
                  ),
                  CompanySignUpForm(),
                ],
              )
            ],
          ),
        ));
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({
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
                    image: AssetImage('images/fotor.jpg'),
                    fit: BoxFit.cover,
                    height: 500,
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
                      const Text(
                        'Enter company name, work email and a password',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.white70),
                      ),
                      CompanySignUpForm(),
                    ],
                  ),
                )
              ],
            )));
  }
}
