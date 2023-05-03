import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Analytics {
  static Future crashEvent(
    String event, {
    String? exception,
    bool fatal = false,
  }) async {
    await FirebaseCrashlytics.instance.recordError(
      event,
      null,
      reason: exception,
      fatal: fatal,
    );
  }

  Future setTrackingScreen(String screenName) async {
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName);
  }
}
