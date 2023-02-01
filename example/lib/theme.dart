import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme._();

  static ThemeData theme(BuildContext context) => ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: _green,
              secondary: _yellow,
            ),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
      );

  static const MaterialColor _green = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      50: Color(0xFFa7d7a3),
      100: Color(0xFF95cf91),
      200: Color(0xFF84c77e),
      300: Color(0xFF72bf6c),
      400: Color(0xFF61b759),
      500: Color(_greenPrimaryValue),
      600: Color(0xFF479e40),
      700: Color(0xFF3f8c39),
      800: Color(0xFF377a32),
      900: Color(0xFF2f692b),
    },
  );
  static const int _greenPrimaryValue = 0xFF4faf47;

  static const MaterialColor _yellow = MaterialColor(
    _yellowPrimaryValue,
    <int, Color>{
      50: Color(0xFFeaec80),
      100: Color(0xFFe5e866),
      200: Color(0xFFe1e44d),
      300: Color(0xFFdde033),
      400: Color(0xFFd8dc19),
      500: Color(_yellowPrimaryValue),
      600: Color(0xFFbfc200),
      700: Color(0xFFaaad00),
      800: Color(0xFF949700),
      900: Color(0xFF7f8200),
    },
  );
  static const int _yellowPrimaryValue = 0xFFd4d800;
}
