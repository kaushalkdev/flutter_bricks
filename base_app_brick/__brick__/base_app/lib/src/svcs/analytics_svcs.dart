import 'package:firebase_analytics/firebase_analytics.dart';

abstract class EventNames {
  static const String homePage = 'home_page';
}

abstract class AnalyticsSvcs {
  void init();
  void homeEvent(Map<String, Object> parameters);
}

class FrbAnalyticsSvs implements AnalyticsSvcs {
  late FirebaseAnalytics _analytics;
  @override
  void init() {
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    _analytics = FirebaseAnalytics.instance;
  }

  @override
  void homeEvent(Map<String, Object> parameters) {
    _analytics.logEvent(name: EventNames.homePage, parameters: parameters);
  }
}
