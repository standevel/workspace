import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peersync/pages/desktop/home.page.dart';
import 'package:peersync/pages/mobile/conpany_signup.dart';
import 'package:peersync/pages/mobile/individual_signup.page.dart';
import 'package:peersync/pages/mobile/login.page.dart';
import 'package:peersync/pages/mobile/signup.page.dart';
import 'package:peersync/pages/mobile/workspace.page.dart';
import 'package:peersync/pages/verify-email.page.dart';

import 'pages/invite_teammates.page.dart';
import 'pages/mobile/dashboard.page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      title: 'Peer Sync',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/signup': (context) => const SignupPage(),
        '/company-signup': (context) => const CompanySignUpPage(),
        '/personal-signup': (context) => const IndividualSignUpPage(),
        '/login': (context) => const LoginPage(),
        '/create-workspace': (context) => const CreateWorkspacePage(),
        "/dashboard": (context) => const DashboardPage(),
        "/verify-email": (context) => const VerifyEmailPage(),
        "/invite-teammates": (context) => const InviteTeammatesPage()
        // Add other named routes for your pages here...
      },
    );
  }

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[900], // Customize the primary color
    colorScheme: ColorScheme.dark(
      primary: Colors.blueGrey[900]!, // Customize the primary color
      secondary: Colors.deepPurple, // Customize the secondary color
    ),
    // Customize the background color
    scaffoldBackgroundColor:
        Colors.blueGrey[900], // Customize the background color
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 30.0, color: Colors.white), // Customize text styles
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
      labelLarge: TextStyle(color: Colors.greenAccent),
      labelMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
            const Size(0, 50)), // Set minimum height of the button
        elevation: MaterialStateProperty.all<double>(
            8.0), // Set elevation for the button
        // Add other customizations to the button style as needed
      ),
    ),
  );

  final lightTheme = ThemeData.light().copyWith(
    primaryColor: const Color.fromARGB(255, 110, 148, 168),
    secondaryHeaderColor: const Color.fromARGB(255, 133, 111, 111),
    scaffoldBackgroundColor: const Color(0xFFF1FAEE),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF333333)),
    ),
    colorScheme: const ColorScheme.light(background: Color(0xFFF1FAEE)),
  );
}
