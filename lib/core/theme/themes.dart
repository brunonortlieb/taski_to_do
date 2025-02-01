import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'color_schemes.g.dart';
part 'text_themes.g.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
  textTheme: textTheme,
  appBarTheme: AppBarTheme(
    titleTextStyle: textTheme.titleMedium,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedLabelStyle: textTheme.titleSmall,
    selectedLabelStyle: textTheme.titleSmall,
    unselectedItemColor: colorScheme.surfaceTint,
    selectedItemColor: colorScheme.primary,
    showUnselectedLabels: true,
    elevation: 0,
  ),
  cardTheme: const CardTheme(
    elevation: 0,
    margin: EdgeInsets.zero,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.zero),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      iconSize: const WidgetStatePropertyAll(24),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      iconColor: WidgetStatePropertyAll(colorScheme.surfaceTint),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    alignLabelWithHint: true,
    fillColor: colorScheme.surfaceContainerLow,
    prefixIconColor: colorScheme.primary,
    prefixIconConstraints: const BoxConstraints(minWidth: 44, maxHeight: 16),
    suffixIconConstraints: const BoxConstraints(minWidth: 44, maxHeight: 16),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
    contentPadding: const EdgeInsets.fromLTRB(14, 15, 14, 14),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.primary.withValues(alpha: 0.5), width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.error, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.primary, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(colorScheme.primary.withValues(alpha: .1)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24, vertical: 22)),
      iconSize: const WidgetStatePropertyAll(13),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    ),
  ),
  disabledColor: colorScheme.surfaceTint,
);
