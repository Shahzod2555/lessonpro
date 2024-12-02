import 'package:flutter/material.dart';
import 'package:lessonproject/frontend/screens/home.dart';
import 'package:lessonproject/frontend/screens/login.dart';
import 'package:lessonproject/frontend/screens/lg.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(

        colorScheme: const ColorScheme(
          brightness: Brightness.light, // Светлая тема
          primary: Colors.redAccent, // Основной цвет
          onPrimary: Colors.white, // Цвет текста/иконок на основном цвете
          secondary: Colors.grey, // Дополнительный цвет
          onSecondary: Colors.black, // Цвет текста/иконок на дополнительном цвете
          error: Colors.red, // Цвет для ошибок
          onError: Colors.white, // Цвет текста на основном фоне
          surface: Colors.white, // Цвет поверхности (например, карточек)
          onSurface: Colors.black, // Цвет текста на поверхности
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        "/": (context) => const HomeScreen(),
        "/login": (context) => const LoginScreen(),
        "/text": (context) => const TextFormFieldExampleApp()
      },
    );
  }
}
