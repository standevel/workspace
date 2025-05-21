import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/responsive.utils.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body:
            // FutureBuilder<bool>(
            //     future: isLoggedIn(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else {
            //         if (snapshot.hasData && snapshot.data != null) {
            //           print('has data: ${snapshot.hasData}');
            //           WidgetsBinding.instance.addPostFrameCallback((_) {
            //             Navigator.pushNamed(context, '/dashboard');
            //           });
            //           return const Center(
            //             child: Text('Redirecting to login...'),
            //           );
            //         } else {
            SingleChildScrollView(
      child: ResponsiveUtils.isMobile(context)
          ? const MobileView()
          : const DesktopView(),
    ));
    //     }
    //   }
    // }));
  }
}

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 8.0,
      ),
      const Image(
        image: AssetImage('assets/images/peersync.png'),
        // width: 100.0,
        // height: 100.0,
        fit: BoxFit.fitHeight,
      ),
      Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          const Text(
            'Bring your work and team together with PeerSync',
            style: TextStyle(fontSize: 40),
          ),
          const Text(
            'Work fast and flexible by communicating effectively.',
            style:
                TextStyle(fontWeight: FontWeight.w300, color: Colors.white70),
          ),
          const SizedBox(
            height: 40,
          ),
          const Image(
            image: AssetImage('assets/images/call2.jpg'),
            // height: 300.0,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).shadowColor,
                    // You can further customize the button style here
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sign up now'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).shadowColor,
                    // You can further customize the button style here
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ]),
      ),
      const SizedBox(
        height: 12.0,
      ),
      Container(
        padding: const EdgeInsets.all(15.0),
        // height: MediaQuery.of(context).size.height * 0.2,
        color: Theme.of(context).shadowColor,
        child: const Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
                'We love using PeerSync. Our efficiency grew by 50% and that\'s amazing'),
            SizedBox(
              height: 8.0,
            ),
            Text('John Vivian, Company CEO')
          ],
        ),
      )
    ]);
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Image(
              image: AssetImage('assets/images/peersync.png'),
              // width: 100.0,
              height: 100.0,
              fit: BoxFit.fitHeight,
            ),
            const Expanded(child: Text('')),
            ResponsiveUtils.isMobile(context)
                ? const Text('')
                : ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).shadowColor,
                      // You can further customize the button style here
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Login'),
                  ),
            const SizedBox(
              width: 20.0,
            )
          ],
        ),
        const SizedBox(
          height: 40.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.4,
                child: Column(
                  children: [
                    const Text(
                      'Bring your work and team together with PeerSync',
                      style: TextStyle(fontSize: 40),
                    ),
                    const Text(
                      'Work fast and flexible by communicating effectively.',
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/signup');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).shadowColor,
                            // You can further customize the button style here
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Sign up now'),
                        ),
                        const Expanded(child: Text(''))
                      ],
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Image(
                  image: AssetImage('assets/images/call2.jpg'),
                  height: 300.0,
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 80.0,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          color: Theme.of(context).shadowColor,
          child: const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                    'We love using PeerSync. Our efficiency grew by 50% and that\'s amazing'),
                SizedBox(
                  height: 8.0,
                ),
                Text('John Vivian, Company CEO')
              ],
            ),
          ),
        )
      ],
    );
  }
}
