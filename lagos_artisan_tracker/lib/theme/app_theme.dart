import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF008751);
  static const Color backgroundWhite = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: primaryGreen,
        surface: backgroundWhite,
      ),
      textTheme: GoogleFonts.outfitTextTheme(),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF5F7F9),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
