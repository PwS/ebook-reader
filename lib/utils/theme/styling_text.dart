import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ebook/utils/theme/colour_palette.dart';

class StylingText {
  StylingText._();

  static TextStyle headLineText = GoogleFonts.poppins(
      color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20);

  static TextStyle bottomNavigationSelected = GoogleFonts.nunitoSans(
    color: ColourPalette.black500,
    fontWeight: FontWeight.w400,
    fontSize: 11,
  );
  static TextStyle bottomNavigationUnSelected = GoogleFonts.nunitoSans(
    color: ColourPalette.black500,
    fontWeight: FontWeight.w400,
    fontSize: 11,
  );
}
