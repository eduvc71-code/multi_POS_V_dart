import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return LightModeTheme();
  }

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color accent20;
  late Color onAccent;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color primary5;
  late Color primary10;
  late Color primary15;
  late Color primary20;
  late Color primary25;
  late Color primary27;
  late Color primary30;
  late Color onPrimary;
  late Color onSecondary;
  late Color onSuccess;
  late Color onError;
  late Color onSurface;
  late Color onBackground;
  late Color onBackground70;
  late Color onBackground80;
  late Color onPrimary20;
  late Color onPrimaryContainer;
  late Color onAccent4;
  late Color surfaceVariant;
  late Color surfaceVariant30;
  late Color surface40;

  TextStyle get headlineLarge => GoogleFonts.urbanist(
        fontSize: 32,
        fontWeight: FontWeight.normal,
      );
  TextStyle get headlineMedium => GoogleFonts.urbanist(
        fontSize: 24,
        fontWeight: FontWeight.normal,
      );
  TextStyle get titleLarge => GoogleFonts.urbanist(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      );
  TextStyle get titleMedium => GoogleFonts.urbanist(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );
  TextStyle get titleSmall => GoogleFonts.urbanist(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
  TextStyle get labelLarge => GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );
  TextStyle get labelMedium => GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  TextStyle get labelSmall => GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );
  TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );
  TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );
}

class LightModeTheme extends FlutterFlowTheme {
  late Color primary = const Color(0xFF0066FF);
  late Color secondary = const Color(0xFFFF2D87);
  late Color tertiary = const Color(0xFFFFE500);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0xFF57636C);
  late Color accent1 = const Color(0x4C0066FF);
  late Color accent2 = const Color(0x4CFF2D87);
  late Color accent3 = const Color(0x4CFFE500);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color accent20 = const Color(0x33FF2D87);
  late Color onAccent = const Color(0xFFFFFFFF);
  late Color success = const Color(0xFF24D193);
  late Color warning = const Color(0xFFFF9100);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);

  late Color primary5 = const Color(0x0D0066FF);
  late Color primary10 = const Color(0x1A0066FF);
  late Color primary15 = const Color(0x260066FF);
  late Color primary20 = const Color(0x330066FF);
  late Color primary25 = const Color(0x400066FF);
  late Color primary27 = const Color(0x450066FF);
  late Color primary30 = const Color(0x4D0066FF);
  late Color onPrimary = const Color(0xFFFFFFFF);
  late Color onSecondary = const Color(0xFFFFFFFF);
  late Color onSuccess = const Color(0xFFFFFFFF);
  late Color onError = const Color(0xFFFFFFFF);
  late Color onSurface = const Color(0xFF14181B);
  late Color onBackground = const Color(0xFFFFFFFF);
  late Color onBackground70 = const Color(0xB3FFFFFF);
  late Color onBackground80 = const Color(0xCCFFFFFF);
  late Color onPrimary20 = const Color(0x33FFFFFF);
  late Color onPrimaryContainer = const Color(0xFF0066FF);
  late Color onAccent4 = const Color(0x1A000000);
  late Color surfaceVariant = const Color(0xFFF1F4F8);
  late Color surfaceVariant30 = const Color(0x4DF1F4F8);
  late Color surface40 = const Color(0x66FFFFFF);
  late Color secondary10 = const Color(0x1AFF2D87);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? font,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    double? letterSpacing,
    double? lineHeight,
  }) {
    return GoogleFonts.getFont(
      font ?? 'Urbanist',
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      height: lineHeight,
    );
  }
}
