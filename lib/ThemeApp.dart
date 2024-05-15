import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
          displaySmall: TextStyle(fontSize: 15, color: Color(0xFF0B0D25)),
          bodyLarge: TextStyle(fontSize: 12, color: Color(0xFF6F9FAB)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF4690A3))),
      backgroundColor: const Color(0xFFF5F5F5),
      secondaryHeaderColor: const Color(0xFF5B7CD3),
      // primarySwatch: Colors.red,
      primaryColor: const Color(0xFF04082F),
      iconTheme: const IconThemeData(color: Color(0Xff94AFB6)),

      shadowColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF6B0808),
        unselectedItemColor: Color(0Xff94AFB6),
      ),
      bottomAppBarColor: isDarkTheme
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color.fromARGB(255, 43, 43, 43),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
        color: Color(0xFF243972),
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme
              ? Colors.white
              : const Color.fromARGB(255, 44, 44, 44)),
    );
  }
}
