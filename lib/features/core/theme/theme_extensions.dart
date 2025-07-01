import 'package:flutter/material.dart';

extension ColorSchemeExtensions on ColorScheme {
  Color get success => brightness == Brightness.light
      ? const Color(0xFF4CAF50)
      : const Color(0xFF66BB6A);
      
  Color get onSuccess => brightness == Brightness.light
      ? Colors.white
      : Colors.black;
      
  Color get successContainer => brightness == Brightness.light
      ? const Color(0xFFE8F5E9)
      : const Color(0xFF2E7D32);
      
  Color get onSuccessContainer => brightness == Brightness.light
      ? const Color(0xFF1B5E20)
      : const Color(0xFFC8E6C9);
      
  Color get warning => brightness == Brightness.light
      ? const Color(0xFFFF9800)
      : const Color(0xFFFFA726);
      
  Color get onWarning => brightness == Brightness.light
      ? Colors.black
      : Colors.black;
      
  Color get warningContainer => brightness == Brightness.light
      ? const Color(0xFFFFF3E0)
      : const Color(0xFFF57C00);
      
  Color get onWarningContainer => brightness == Brightness.light
      ? const Color(0xFFE65100)
      : const Color(0xFFFFE0B2);
}