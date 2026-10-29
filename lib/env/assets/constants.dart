part of '../env.dart';

class Constants {
  static const Curve curve = Curves.easeInOut;
  static const Duration duration = Duration(milliseconds: 300);
  static const double spacing = 20.0;
  static const double drawer = 250.0;

  // Company details used across the page
  static const String company = 'Meridian Advisory Group';
  static const String brand = 'MERIDIAN';
  static const String tagline = 'Strategy & Management Consulting';
  static const String email = 'hello@meridian-advisory.example';
  static const String phone = '+1 (555) 010-2400';
  static const String address = '220 Harbor Street, Suite 900, Boston, MA';
  static const String hours = 'Mon – Fri, 8:30 – 18:00 EST';
  static const String website =
      'https://alinchenescu.github.io/consulting-landing-page';

  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
      dividerColor: Colors.transparent,
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.black.withOpacity(0.15)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedLabelStyle: TextStyle(fontSize: 10.0, color: Colors.black),
          selectedLabelStyle:
              TextStyle(fontSize: 10.0, color: Color((0xff0B2545)))),
      textTheme: TextTheme(
          titleLarge: const TextStyle(
              fontSize: 46.0, color: Colors.white, letterSpacing: -0.5),
          titleMedium: const TextStyle(fontSize: 18.0, color: Colors.white),
          bodyMedium: TextStyle(
              fontSize: 14.0,
              height: 1.5,
              color: Colors.white.withOpacity(0.7)),
          bodySmall: TextStyle(
            fontSize: 13.0,
            height: 1.6,
            color: Colors.white.withOpacity(0.7),
          )),
      colorScheme: const ColorScheme.light(
          error: Color(0xFFBF215A),
          primary: Color(0xff0B2545),
          secondary: Color(0xffD4A72C),
          background: Colors.white,
          onPrimary: Colors.white,
          onBackground: Color(0xff0A1628),
          outline: Color(0xff5B6B82),
          surface: Color(0xffF4F7FB)));
}
