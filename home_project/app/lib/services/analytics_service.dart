import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logEvent(String eventName, {Map<String, Object?>? parameters}) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  Future<void> setUserProperties({String? userId, String? userRole}) async {
    await _analytics.setUserId(id: userId);
    await _analytics.setUserProperty(name: 'role', value: userRole);
  }

  // Log specific events
  Future<void> logLoginEvent(String loginMethod) async {
    await logEvent('login', parameters: {
      'method': loginMethod,
    });
  }

  Future<void> logSignUpEvent(String signUpMethod) async {
    await logEvent('sign_up', parameters: {
      'method': signUpMethod,
    });
  }

  // Add more event logging functions as needed for your application
}