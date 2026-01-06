import 'package:flutter/material.dart';
class VelPasColors {
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

class VelPasTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = base.textTheme.apply(
      bodyColor: VelPasColors.silverPrimary,
      displayColor: VelPasColors.silverPrimary,
      fontFamily: 'Avenir Next',
    );

    return base.copyWith(
      scaffoldBackgroundColor: VelPasColors.bg0,
      canvasColor: VelPasColors.bg0,
      cardColor: VelPasColors.bg1,
      colorScheme: ColorScheme.fromSeed(
        seedColor: VelPasColors.champagne,
        brightness: Brightness.dark,
        primary: VelPasColors.champagne,
        onPrimary: VelPasColors.bg0,
        secondary: VelPasColors.champagneDeep,
        onSecondary: VelPasColors.bg0,
        surface: VelPasColors.bg1,
        onSurface: VelPasColors.silverPrimary,
        background: VelPasColors.bg0,
        onBackground: VelPasColors.silverPrimary,
        error: VelPasColors.danger,
        onError: VelPasColors.bg0,
      ),
      textTheme: textTheme.copyWith(
        titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        titleMedium: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        titleSmall: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: VelPasColors.bg0,
        foregroundColor: VelPasColors.silverPrimary,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: VelPasColors.divider,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: VelPasColors.bg1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: VelPasColors.stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: VelPasColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: VelPasColors.champagne),
        ),
        labelStyle: const TextStyle(color: VelPasColors.silverSecondary),
        hintStyle: const TextStyle(color: VelPasColors.silverTertiary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: VelPasColors.bg1,
        indicatorColor: VelPasColors.bg2,
        labelTextStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(
            color: states.contains(MaterialState.selected)
                ? VelPasColors.champagne
                : VelPasColors.silverSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: MaterialStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(MaterialState.selected)
                ? VelPasColors.champagne
                : VelPasColors.silverSecondary,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: VelPasColors.bg2,
        labelStyle: const TextStyle(color: VelPasColors.silverPrimary),
        shape: StadiumBorder(
          side: BorderSide(color: VelPasColors.stroke),
        ),
      ),
    );
  }
}
