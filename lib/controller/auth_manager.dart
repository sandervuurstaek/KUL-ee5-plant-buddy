import 'package:flutter/foundation.dart';

class AuthManager {

  static final ValueNotifier<bool> _loggedIn = ValueNotifier(false);

  static ValueNotifier<bool> get loggedInNotifier => _loggedIn;
  static bool get isLoggedIn => _loggedIn.value;

  static bool logined() {
    _loggedIn.value = true;
    return true;
  }
}
