import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class Analytics {
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
}
