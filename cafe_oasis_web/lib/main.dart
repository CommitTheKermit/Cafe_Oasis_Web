import 'package:cafe_oasis_web/screens/main_screens/cafe_search_screen.dart';
import 'package:cafe_oasis_web/screens/user_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const AppLingua());
}

class AppLingua extends StatelessWidget {
  const AppLingua({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Neo',
        primaryColor: const Color(0xFF8FC1E4),
        cardColor: const Color(0xFFF49349),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFF49349),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
