import 'package:flutter/material.dart';
import 'routes/routes.dart';

void main() { runApp(const MyApp()); }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppPage.routes,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
