import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'providers/index.dart';
import 'screens/index.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const LetTutorApp());
}

class LetTutorApp extends StatelessWidget {
  const LetTutorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          home: auth.isAuth ? const TabsScreen() : const OnboardScreen(),
          routes: {
            OnboardScreen.routeName: (context) => const OnboardScreen(),
            TabsScreen.routeName: (context) => const TabsScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            SignUpScreen.routeName: (context) => const SignUpScreen(),
            TutorsScreen.routeName: (context) => const TutorsScreen(),
            TutorDetailScreen.routeName: (context) => const TutorDetailScreen(),
            CourseScreen.routeName: (context) => const CourseScreen(),
            BookingHistoryScreen.routeName: (context) => const BookingHistoryScreen(),
            MessageScreen.routeName: (context) => const MessageScreen(),
            UpcomingScreen.routeName: (context) => const UpcomingScreen(),
            MeetingScreen.routeName: (context) => const MeetingScreen(),
            ViewFeedbacksScreen.routeName: (context) => const ViewFeedbacksScreen(),
            SessionHistoryScreen.routeName: (context) => const SessionHistoryScreen(),
            AdvancedSettingsScreen.routeName: (context) => const AdvancedSettingsScreen(),
          },
        ),
      ),
    );
  }
}
