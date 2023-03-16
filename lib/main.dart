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
        TutorsScreen.routeName: (context) => const TutorsScreen(),
        TutorDetailScreen.routeName: (context) => const TutorDetailScreen(),
        CourseScreen.routeName: (context) => const CourseScreen(),
        BookingHistoryScreen.routeName: (context) => const BookingHistoryScreen(),
        MessageScreen.routeName: (context) => const MessageScreen(),
        UpcomingScreen.routeName: (context) => const UpcomingScreen(),
        MeetingScreen.routeName: (context) => const MeetingScreen(),
        ViewFeedbacksScreen.routeName: (context) => const ViewFeedbacksScreen(),
      },
    );
  }
}
