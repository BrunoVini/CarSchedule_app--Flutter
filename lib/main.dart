import 'package:car_app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('pt'),
    ],
  ));
}
