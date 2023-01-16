import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static const textTheme = TextTheme(
    headline1: TextStyle(fontSize: 52, fontWeight: FontWeight.w400),
    headline2: TextStyle(fontSize: 46, fontWeight: FontWeight.w600),
    headline3: TextStyle(fontSize: 38, fontWeight: FontWeight.w400),
    headline4: TextStyle(fontSize: 34, fontWeight: FontWeight.w400),
    headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    headline6: TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
    subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    subtitle2: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
    bodyText1: TextStyle(fontSize: 16),
    bodyText2: TextStyle(fontSize: 13),
    caption: TextStyle(fontSize: 11),
  );

  static TextButtonThemeData textButtonTheme(
    Color onBackground,
  ) =>
      TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.dragged) ||
                  states.contains(MaterialState.selected) ||
                  states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return AppColors.primary;
              }
              return AppColors.secondary;
            },
          ),
        ),
      );

  static ThemeData get lightTheme => ThemeData.light().copyWith(
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          background: AppColors.backgroundLM,
          onBackground: AppColors.onBackgroundLM,
          surface: AppColors.surfaceLM,
          onSurface: AppColors.onSurfaceLM,
          outline: AppColors.outlineLM,
        ),
        backgroundColor: AppColors.backgroundLM,
        scaffoldBackgroundColor: AppColors.backgroundLM,
        textTheme: GoogleFonts.latoTextTheme(textTheme).apply(
          displayColor: AppColors.onSurfaceLM,
          bodyColor: AppColors.onBackgroundLM,
        ),
        primaryColorLight: AppColors.primary,
        primaryColorDark: AppColors.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surfaceLM,
          foregroundColor: AppColors.onSurfaceLM,
        ),
        cardTheme: CardTheme(
          elevation: 14,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        dividerTheme: const DividerThemeData(
          thickness: 1,
          space: 10,
          color: AppColors.dividerLM,
        ),
        textButtonTheme: textButtonTheme(AppColors.onBackgroundLM),
      );
}

class AppColors {
  static const primary = Color(0xFF3182CE);
  static const onPrimary = Color(0xFFFFFFFF);

  static const secondary = Color(0xFF319795);
  static const onSecondary = Color(0xFFFFFFFF);

  static const backgroundLM = Color(0xFFFFFFFF);
  static const onBackgroundLM = Color(0xFF718096);

  static const surfaceLM = Color(0xFFFFFFFF);
  static const onSurfaceLM = Color(0xFF4A5568);

  static const outlineLM = Color(0xFFF7FAFC);
  static const dividerLM = Color(0xFFCBD5E0);
}
