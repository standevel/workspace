import 'package:flutter/material.dart';
import 'package:peersync/form/company_signup.form.dart';
import 'package:peersync/pages/desktop/company_signup.dart';

import '../../utils/responsive.utils.dart';

class CompanySignUpPage extends StatelessWidget {
  const CompanySignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // debugPrint('view: $isMobileView');
    // debugPrint('view: ${const MediaQueryData().size.width}');
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('PeerSync'),
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              return ResponsiveUtils.isMobile(context)
                  ? const CompanySignUpMobileView() // Render mobile-optimized view
                  : const CompanySignUpDesktopView(); // Render desktop-optimized view
            },
          ),
        ),
      ),
    );
  }
}

class CompanySignUpMobileView extends StatelessWidget {
  const CompanySignUpMobileView({super.key});

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
                image: AssetImage('assets/images/fotor.jpg'),
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
                    'Enter your name, work email and a password',
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.white70),
                  ),
                  CompanyForm(
                    navigateToCreateWorkspace: () {
                      // Navigate to CreateWorkspacePage
                      Navigator.of(context).pushNamed('/create-workspace');
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
