import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import 'pages/login.dart';
import 'pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeltaStore',
      //Rotas
      routes: {
        '/':(context)           => WelcomePage(),
        '/Registrar':(context)  => SignupPage(),
        '/Login':(context)      => LoginPage()
      },

      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

