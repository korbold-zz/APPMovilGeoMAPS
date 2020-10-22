import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorPrimary = Color.fromRGBO(0, 131, 154, 1);

final themeAPP = ThemeData(
  brightness: Brightness.light,
  primaryColor: colorPrimary,
  accentColor: Colors.cyan[600],
  textTheme: GoogleFonts.rubikTextTheme().apply(),
  
);
