import 'package:flutter/foundation.dart';

/// Switches that control monetisation.
///
/// Ads show only while [adsEnabled] is on and the user is not [isPremium].
/// When paid subscriptions arrive, set [isPremium] from the purchase state and
/// the ad banner disappears everywhere.
class AppFlags extends ChangeNotifier {
  AppFlags._();
  static final AppFlags instance = AppFlags._();

  bool _adsEnabled = true;
  bool _isPremium = false;

  bool get adsEnabled => _adsEnabled;
  bool get isPremium => _isPremium;
  bool get showAds => _adsEnabled && !_isPremium;

  set adsEnabled(bool v) {
    if (v == _adsEnabled) return;
    _adsEnabled = v;
    notifyListeners();
  }

  set isPremium(bool v) {
    if (v == _isPremium) return;
    _isPremium = v;
    notifyListeners();
  }
}
