import 'package:flutter/material.dart';

import 'screens/index.dart';

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
      home: const OnboardScreen(),
      routes: {
        OnboardScreen.routeName: (context) => const OnboardScreen(),
        TabsScreen.routeName: (context) => const TabsScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        TutorDetailScreen.routeName: (context) => const TutorDetailScreen(),
      },
    );
  }
}
