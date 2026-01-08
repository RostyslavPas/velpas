import 'package:flutter/material.dart';

class ProsToColors {
  static const bg0 = Color(0xFF0B0D10);
  static const bg1 = Color(0xFF11141A);
  static const bg2 = Color(0xFF161B22);

  static const silverPrimary = Color(0xFFE7E1D6);
  static const silverSecondary = Color(0xFFBFB7AB);
  static const silverTertiary = Color(0xFF7D776F);

  static const champagne = Color(0xFFD6C3A1);
  static const champagneDeep = Color(0xFFBFA47A);

  static const stroke = Color(0xFF242C38);
  static const divider = Color(0xFF1C2330);

  static const ok = Color(0xFF7CCB8A);
  static const warn = Color(0xFFE2C56B);
  static const danger = Color(0xFFE07A7A);
}

class ProsToTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = base.textTheme.apply(
      bodyColor: ProsToColors.silverPrimary,
      displayColor: ProsToColors.silverPrimary,
      fontFamily: 'Avenir Next',
    );

    return base.copyWith(
      scaffoldBackgroundColor: ProsToColors.bg0,
      canvasColor: ProsToColors.bg0,
      cardColor: ProsToColors.bg1,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ProsToColors.champagne,
        brightness: Brightness.dark,
        primary: ProsToColors.champagne,
        onPrimary: ProsToColors.bg0,
        secondary: ProsToColors.champagneDeep,
        onSecondary: ProsToColors.bg0,
        surface: ProsToColors.bg1,
        onSurface: ProsToColors.silverPrimary,
        background: ProsToColors.bg0,
        onBackground: ProsToColors.silverPrimary,
        error: ProsToColors.danger,
        onError: ProsToColors.bg0,
      ),
      textTheme: textTheme.copyWith(
        titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        titleMedium: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        titleSmall: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ProsToColors.bg0,
        foregroundColor: ProsToColors.silverPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      dividerTheme: const DividerThemeData(
        color: ProsToColors.divider,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ProsToColors.bg1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ProsToColors.stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ProsToColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ProsToColors.champagne),
        ),
        labelStyle: const TextStyle(color: ProsToColors.silverSecondary),
        hintStyle: const TextStyle(color: ProsToColors.silverTertiary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ProsToColors.bg1,
        indicatorColor: ProsToColors.bg2,
        labelTextStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(
            color: states.contains(MaterialState.selected)
                ? ProsToColors.champagne
                : ProsToColors.silverSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: MaterialStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(MaterialState.selected)
                ? ProsToColors.champagne
                : ProsToColors.silverSecondary,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: ProsToColors.bg2,
        labelStyle: const TextStyle(color: ProsToColors.silverPrimary),
        shape: StadiumBorder(
          side: BorderSide(color: ProsToColors.stroke),
        ),
      ),
    );
  }
}
