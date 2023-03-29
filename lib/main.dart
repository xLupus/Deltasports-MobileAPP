import 'package:deltasports_app/index.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/sing_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':(context)           => HomePage(),
        '/Registrar':(context)  => RegisterPage(),
        '/Login':(context)      => LoginPage()
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
