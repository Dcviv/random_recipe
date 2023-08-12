import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

textStyle(double size, [Color? color, FontWeight? fw]) {
  // things inside square brackets are optional
  return GoogleFonts.montserrat(fontSize: size, color: color, fontWeight: fw);
}
