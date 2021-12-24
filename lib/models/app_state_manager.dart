import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Creates constants for each tab the user taps.
class SutoriteraTab {
  static const int explore = 0;
  static const int create = 1;
  static const int profile = 2;
}

class AppStateManager extends ChangeNotifier {
  // _initialized checks if the app is initialized.
  bool _initialized = false;
  // _loggedIn lets you check if the user has logged in.
  bool _loggedIn = false;
  // _selectedTab keeps track of which tab the user is on.
  int _selectedTab = SutoriteraTab.explore;
  bool _darkMode = false;

  // These are getter methods for each property.
  //You cannot change these properties outside AppStateManager.
  //This is important for the unidirectional flow architecture, where you don’t
  //change state directly but only via function calls or dispatched events.
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isDarkMode => _darkMode;
  int get getSelectedTab => _selectedTab;
  late SharedPreferences _pref;
  void initializeApp() async {
    // Sets a delayed timer for 2,000 milliseconds before executing the closure.
    //This sets how long the app screen will display after the user starts the
    //app.
    _pref = await SharedPreferences.getInstance();
    _darkMode = _pref.getBool('darkMode') ?? false;

    Timer(
      const Duration(milliseconds: 2000),
      () {
        // Sets initialized to true.
        _initialized = true;
        // Notifies all listeners.
        notifyListeners();
      },
    );
  }

  void changeTheme() {
    _darkMode = !_darkMode;
    _pref.setBool("darkMode", _darkMode);
  }

  void login(String username, String password) {
    // Also here you can implement backend logic
    // Sets loggedIn to true.
    _loggedIn = true;
    // Notifies all listeners.
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void logout() {
    // Resets all app state properties.
    _loggedIn = false;
    _initialized = false;
    _selectedTab = 0;

    // Reinitializes the app.
    initializeApp();
    // Notifies all listeners of state change.
    notifyListeners();
  }
}
