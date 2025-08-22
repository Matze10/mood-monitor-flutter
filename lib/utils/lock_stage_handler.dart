import 'package:flutter/foundation.dart';

class LockStageHandler extends ChangeNotifier {
  bool _locked = true;

  bool get locked => _locked;

  void lock() {
    if (!_locked) {
      _locked = true;
      notifyListeners();
    }
  }

  void unlock() {
    if (_locked) {
      _locked = false;
      notifyListeners();
    }
  }
}
