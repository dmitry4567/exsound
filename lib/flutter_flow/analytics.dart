import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

void logSignUp(String registrationSource) async {
  await _analytics.logEvent(
      name: "sign_up",
      parameters: {"registration_source": registrationSource});
}

void logStartWorkout(
    int workoutId, int workoutType, int workoutStartTimestamp) async {
  await _analytics.logEvent(name: "start_workout", parameters: {
    "workout_id": workoutId,
    "workout_type": workoutType,
    "workout_start_timestamp": workoutStartTimestamp
  });
}

void logCompleteWorkout(
    int workoutId, int workoutType, int workoutCompleteTimestamp) async {
  await _analytics.logEvent(name: "start_workout", parameters: {
    "workout_id": workoutId,
    "workout_type": workoutType,
    "workout_complete_timestamp": workoutCompleteTimestamp
  });
}

void logOpenApp(String userId, int openAppTimestamp) async {
  await _analytics.logEvent(name: "open_app", parameters: {
    "user_id": userId,
    "open_app_timestamp": openAppTimestamp,
  });
}

void logCloseApp(String userId, int closeAppTimestamp) async {
  await _analytics.logEvent(name: "close_app", parameters: {
    "user_id": userId,
    "close_app_timestamp": closeAppTimestamp,
  });
}

void logOpenScreen(String userId, String screenName) async {
  await _analytics.logEvent(
      name: "open_screen",
      parameters: {"user_id": userId, "screen_name": screenName});
}
