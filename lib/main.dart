import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());  // Ajout du mot clé const ici
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  // Ajout du constructeur const et super.key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolo AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Roboto'),
      ),
      home: const DashboardScreen(),  
    );
  }
}
