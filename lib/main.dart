import 'package:flutter/material.dart';

import 'screens/auth/login_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const LetTutorIntroScreen(),
      routes: {
        LetTutorTabsScreen.routeName: (context) => const LetTutorTabsScreen(),
        LetTutorLoginScreen.routeName: (context) => const LetTutorLoginScreen(),
      },
    );
  }
}
