part of 'themes.dart';

TextTheme textTheme = GoogleFonts.urbanistTextTheme().copyWith(
  titleLarge: GoogleFonts.urbanistTextTheme().titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
        height: 1.2,
      ),
  titleMedium: GoogleFonts.urbanistTextTheme().titleSmall?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        height: 1.2,
      ),
  titleSmall: GoogleFonts.urbanistTextTheme().titleSmall?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
        height: 1.2,
      ),
  bodyLarge: GoogleFonts.urbanistTextTheme().bodyMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurfaceVariant,
        height: 1.2,
      ),
  bodyMedium: GoogleFonts.urbanistTextTheme().bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurfaceVariant,
        height: 1.285,
      ),
  labelLarge: GoogleFonts.urbanistTextTheme().titleSmall?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
);
