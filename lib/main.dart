import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/settings/presentation/settings_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color _primaryColor = Color(0xFF384569); // bottom bar navy
  static const Color _backgroundColor = Color(0xFFF3F3F3); // light grey bg

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile & Settings',
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: _backgroundColor,
        primaryColor: _primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        textTheme: baseTheme.textTheme.apply(
          fontFamily: 'Roboto',
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 22,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
          dense: false,
        ),
        colorScheme: baseTheme.colorScheme.copyWith(
          primary: _primaryColor,
          secondary: _primaryColor,
          surface: Colors.white,
        ),
      ),
      home: const SettingsPage(),
    );
  }
}
