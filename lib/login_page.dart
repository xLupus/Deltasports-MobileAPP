import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.phone_android,
                size: 100,
              ),
              SizedBox(height: 75),
        //BemVindo
        Text(
          'Bem-vindo(a)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            ),
        ),
        SizedBox(height: 10),
        Text(
          'Faça o login ou cadastre-se para continuar',
          style: TextStyle(
            fontSize: 16,
            ),
        ),
        SizedBox(height: 18),

        //Email
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email',
            ),
          ),
        ),
      ),
    ),
    SizedBox(height: 18),
    //Senha
    Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Senha',
            ),
          ),
        ),
      ),
    ),
    SizedBox(height: 18),
    //Btn entrar
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Entrar',
            style:TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              ),
            ),
          ),
        ),
      ),
  ]
          ),
        ),
      ),
    );
  }
}