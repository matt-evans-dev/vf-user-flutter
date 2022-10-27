import 'package:rxdart/rxdart.dart';

class ThemeStore {
  BehaviorSubject<bool> isDarkTheme;

  ThemeStore(bool savedValue) {
    isDarkTheme = BehaviorSubject<bool>.seeded(savedValue);
  }

  void updateTheme(bool value) {
    isDarkTheme.add(value);
  }
}
