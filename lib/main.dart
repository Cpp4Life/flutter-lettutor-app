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
        ),
        ChangeNotifierProxyProvider<AuthProvider, TutorProvider>(
          create: (context) => TutorProvider('', []),
          update: (context, auth, previousTutors) => TutorProvider(
            auth.token ?? '',
            previousTutors == null ? [] : previousTutors.tutors,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CourseProvider>(
          create: (context) => CourseProvider('', []),
          update: (context, auth, previousCourses) => CourseProvider(
            auth.token ?? '',
            previousCourses == null ? [] : previousCourses.courses,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, EbookProvider>(
          create: (context) => EbookProvider('', []),
          update: (context, auth, previousEbooks) => EbookProvider(
            auth.token ?? '',
            previousEbooks == null ? [] : previousEbooks.ebooks,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(''),
          update: (context, auth, previous) => UserProvider(
            auth.token ?? '',
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ScheduleProvider>(
          create: (context) => ScheduleProvider('', []),
          update: (context, auth, previousSchedules) => ScheduleProvider(
            auth.token ?? '',
            previousSchedules == null ? [] : previousSchedules.schedules,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LearnTopicProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TestPreparationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Poppins',
          ),
          home: auth.isAuth
              ? const TabsScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const OnboardScreen();
                  },
                ),
          routes: {
            OnboardScreen.routeName: (context) => const OnboardScreen(),
            TabsScreen.routeName: (context) => const TabsScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            SignUpScreen.routeName: (context) => const SignUpScreen(),
            ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
            TutorsScreen.routeName: (context) => const TutorsScreen(),
            TutorDetailScreen.routeName: (context) => const TutorDetailScreen(),
            CourseScreen.routeName: (context) => const CourseScreen(),
            CourseDetailScreen.routeName: (context) => const CourseDetailScreen(),
            BookingHistoryScreen.routeName: (context) => const BookingHistoryScreen(),
            MessageScreen.routeName: (context) => const MessageScreen(),
            UpcomingScreen.routeName: (context) => const UpcomingScreen(),
            MeetingScreen.routeName: (context) => const MeetingScreen(),
            ViewFeedbacksScreen.routeName: (context) => const ViewFeedbacksScreen(),
            SessionHistoryScreen.routeName: (context) => const SessionHistoryScreen(),
            AdvancedSettingsScreen.routeName: (context) => const AdvancedSettingsScreen(),
            ProfileScreen.routeName: (context) => const ProfileScreen(),
            ChatGPTScreen.routeName: (context) => const ChatGPTScreen(),
          },
        ),
      ),
    );
  }
}
