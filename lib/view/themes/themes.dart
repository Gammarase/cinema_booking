import 'package:flutter/material.dart';

class Themes {
  static get dark {
    return ThemeData(
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
      ),
      cardTheme: CardTheme(
        color: Colors.black.withOpacity(0.1),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: const Color(0xFF252525),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF252525),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(size: 35),
          elevation: 0),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: "Quicksand", fontSize: 36, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(
            fontFamily: "Quicksand", fontSize: 28, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(
            fontFamily: "Quicksand", fontSize: 24, fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(
            fontFamily: "Quicksand", fontSize: 22, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
            color: Colors.black12,
            fontFamily: "Quicksand",
            fontSize: 16,
            fontWeight: FontWeight.w500),
        labelLarge: TextStyle(
            fontFamily: "Quicksand", fontSize: 24, fontWeight: FontWeight.w500),
      ).apply(bodyColor: Colors.white, displayColor: Colors.white),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        background: const Color(0xFF252525),
        primary: const Color(0xFFE01A67),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(10),
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      dialogTheme: const DialogTheme(
          backgroundColor: Color(0xFF252525),
          contentTextStyle: TextStyle(
              fontFamily: "Quicksand",
              fontSize: 16,
              fontWeight: FontWeight.w500),
          titleTextStyle: TextStyle(
              fontFamily: "Quicksand",
              fontSize: 24,
              fontWeight: FontWeight.w700)),
      dividerColor: Colors.white,
      canvasColor: const Color(0xFF252525),
    );
  }

  static get light {
    return ThemeData(
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
      ),
      cardTheme: CardTheme(
        color: Colors.black.withOpacity(0.1),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF252525)),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(size: 35),
          elevation: 0),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: "Quicksand", fontSize: 36, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(
            fontFamily: "Quicksand", fontSize: 28, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(
            fontFamily: "Quicksand", fontSize: 24, fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(
            fontFamily: "Quicksand", fontSize: 22, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
            color: Colors.black12,
            fontFamily: "Quicksand",
            fontSize: 16,
            fontWeight: FontWeight.w500),
        labelLarge: TextStyle(
            fontFamily: "Quicksand", fontSize: 24, fontWeight: FontWeight.w500),
      ).apply(bodyColor: Colors.black, displayColor: Colors.black),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        background: Colors.white,
        primary: const Color(0xFFE01A67),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(10),
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      dialogTheme: const DialogTheme(
          contentTextStyle: TextStyle(
              fontFamily: "Quicksand",
              fontSize: 16,
              fontWeight: FontWeight.w500),
          titleTextStyle: TextStyle(
              fontFamily: "Quicksand",
              fontSize: 24,
              fontWeight: FontWeight.w700)),
      dividerColor: Colors.black,
    );
  }
}
