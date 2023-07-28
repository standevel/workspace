import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peersync/app_router.dart';

void main() {
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
      onGenerateRoute: AppRouter.generateRoute,
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
