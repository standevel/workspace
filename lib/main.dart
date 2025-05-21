import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peersync/constants.dart';
import 'package:peersync/enums/event_type.enum.dart';
import 'package:peersync/pages/dashboard.page.dart';
import 'package:peersync/pages/desktop/home.page.dart';
import 'package:peersync/pages/mobile/call.mobile.dart';
import 'package:peersync/pages/mobile/chat.mobile.dart';
import 'package:peersync/pages/mobile/conpany_signup.dart';
import 'package:peersync/pages/mobile/dashboard.mobile.page.dart';
import 'package:peersync/pages/mobile/individual_signup.page.dart';
import 'package:peersync/pages/mobile/login.page.dart';
import 'package:peersync/pages/mobile/signup.page.dart';
import 'package:peersync/pages/mobile/workspace.page.dart';
import 'package:peersync/pages/verify-email.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: library_prefixes

import 'pages/invite_teammates.page.dart';
import 'pages/desktop/dashboard.page.dart';
import 'providers/socket_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) async {
    // prefs.clear();
    var token = prefs.getString(tokenName);
    if (token != null) {
      // Instantiate the socket manager
      var user = await getUser();
      SocketManager socketManager = SocketManager();
      socketManager.socket.on(EVENT, (data) {
        // print('event data: $data');
      });
// Connect to the Socket.IO server
      socketManager.connect(user.id!); // Initialize SocketManager if logged in
    }
  });

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
      onGenerateRoute: (settings) {
        // Implement route generation logic here
        return MaterialPageRoute(
          builder: (context) => const TeamDashboardMobilePage(),
        );
      },
      routes: {
        '/': (context) => const HomePage(),
        '/chat': (context) => const ChatPage(),
        '/call': (context) => const CallPage(),
        '/signup': (context) => const SignupPage(),
        '/company-signup': (context) => const CompanySignUpPage(),
        '/personal-signup': (context) => const IndividualSignUpPage(),
        '/login': (context) => const LoginPage(),
        '/create-workspace': (context) => const CreateWorkspacePage(),
        "/dashboard": (context) => const Dashboard(),
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
    // textTheme: const TextTheme(
    //   displayLarge: TextStyle(
    //       fontSize: 30.0, color: Colors.white), // Customize text styles
    //   bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    // labelLarge: TextStyle(color: Colors.greenAccent),
    // labelMedium: TextStyle(color: Colors.white),
    // labelSmall: TextStyle(color: Colors.white),
    // titleLarge: TextStyle(color: Colors.white),
    // titleMedium: TextStyle(color: Colors.white),
    // titleSmall: TextStyle(color: Colors.white),
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        ),
        minimumSize: WidgetStateProperty.all<Size>(
            const Size(0, 50)), // Set minimum height of the button
        elevation: WidgetStateProperty.all<double>(
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
    // colorScheme: const ColorScheme.light(background: Color(0xFFF1FAEE)),
  );
}
