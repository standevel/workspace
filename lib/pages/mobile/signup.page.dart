import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../utils/responsive.utils.dart';

class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) {
            return ResponsiveUtils.isMobile(context)
                ? SignUpMobileView(ref) // Render mobile-optimized view
                : SignUpDesktopView(ref); // Render desktop-optimized view
          },
        ),
      ),
    );
  }
}

class SignUpDesktopView extends StatelessWidget {
  final WidgetRef ref;
  const SignUpDesktopView(
    this.ref, {
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Center(
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: const Image(
                image: AssetImage('assets/images/comm.jpg'),
                // width: 100.0,
                // height: 100.0,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/company-signup');
                      },
                      child: Card(
                        color: Colors.blueGrey[
                            800], // Darker color than the form background
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Company Account',
                                style: TextStyle(fontSize: 28),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Company account helps you manage different workspaces and onboard several hundreds of users with pro features',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueGrey[200]),
                              ),
                              Text(
                                'Company wide File manager',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueGrey[200]),
                              ),
                              Text(
                                'Robost Access control and permission system',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueGrey[200]),
                              ),
                              Text(
                                'Unlimited calls and recording with liveboard',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueGrey[200]),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/company-signup');
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.blueGrey[200]),
                                child: const Text('Continue as Company'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/personal-signup');
                      },
                      child: Card(
                        color: Colors.blueGrey[
                            800], // Darker color than the form background
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Personal Account',
                                style: TextStyle(fontSize: 28),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Personal account helps you collaborate with up to 10 people in your workspace. You can upgrade to company at any time',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueGrey[200]),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/personal-signup');
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.blueGrey[200]),
                                child: const Text('Continue as Personal'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class SignUpMobileView extends StatelessWidget {
  final WidgetRef ref;
  const SignUpMobileView(
    this.ref, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.3,
          width: MediaQuery.sizeOf(context).width,
          child: const Image(
            image: AssetImage('images/comm.jpg'),
            // width: 100.0,
            // height: 100.0,
            fit: BoxFit.fitWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/company-signup');
                },
                child: Card(
                  color: Colors
                      .blueGrey[800], // Darker color than the form background
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Company Account',
                          style: TextStyle(fontSize: 28),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Company account helps you manage different workspaces and onboard several hundreds of users with pro features',
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueGrey[200]),
                        ),
                        Text(
                          'Company wide File manager',
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueGrey[200]),
                        ),
                        Text(
                          'Robost Access control and permission system',
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueGrey[200]),
                        ),
                        Text(
                          'Unlimited calls and recording with liveboard',
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueGrey[200]),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/company-signup');
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.blueGrey[200]),
                          child: const Text('Continue as Company'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/personal-signup');
                },
                child: Card(
                  color: Colors
                      .blueGrey[800], // Darker color than the form background
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personal Account',
                          style: TextStyle(fontSize: 28),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Personal account helps you collaborate with up to 10 people in your workspace. You can upgrade to company at any time',
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueGrey[200]),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/personal-signup');
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.blueGrey[200]),
                          child: const Text('Continue as Personal'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Column SignUpMobileView{}
