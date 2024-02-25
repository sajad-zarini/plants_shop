import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:plants_app/core/l10n/l10n.dart';
import 'package:plants_app/core/theme/theme.dart';
import 'package:plants_app/pages/on_board/screens/onboard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const PlantHome());
}

class PlantHome extends StatelessWidget {
  const PlantHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate 
      ],
      supportedLocales: L10n.all,
      theme: AppTheme.appTheme.copyWith(),
      home: const OnBoard(),
    );
  }
}