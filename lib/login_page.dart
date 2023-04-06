import 'dart:convert';

import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: GlobalColors.white,
      body: Form(
        key: _formkey,
        child: Center(
          child: Column(children: [
            SizedBox(height: 10),
            Image.network('https://i.imgur.com/aSEadiB.png'),
          

            SizedBox(height: 40),

            //BemVindo
            Container(
              child: Align(
                alignment: Alignment(-0.75,0.0),
                child: Text(
                  'Bem-vindo(a)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            Container(
              child: Align(
                alignment: Alignment(-0.4,0.0),
                child: Text(
                  'Faça o login ou cadastre-se para continuar',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            SizedBox(height: 18),

            //Email 0xFF1C8394
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: GlobalColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (email){
                      if(email == null || email.isEmpty){
                        return 'Por favor, digite seu e-mail';
                      }else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.text)) {
                      return 'Por favor, digite um e-mail correto';
                    }
                    return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                  color: GlobalColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    controller: _senhaController,
                    validator: (senha){
                      if(senha == null || senha.isEmpty){
                        return 'Por favor, digite sua senha';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                  ),

                  
                ),
              ),
            ),

            SizedBox(height: 80),

            //Btn entrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).pushReplacementNamed(
                    '/Produtos'
                  )
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GlobalColors.red,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:  [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                  ),
                  child: Center(
                    child: Text(
                      'Logar',
                      style: TextStyle(
                        color: GlobalColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 35),

            //Btn voltar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).pushNamed('/'),
                },
                child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: GlobalColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: GlobalColors.blue),
                  boxShadow:  [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                      color: GlobalColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            ),
          ]),
        ),
      ),
    );
  }

   Future<bool> login() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/ditto');
    var resposta = await http.post(url,
    body: {
      'USUARIO_EMAIL': _emailController.text,
      'USUARIO_SENHA': _senhaController.text,

    }
    );
    if(resposta.statusCode == 200){
      print(jsonDecode(resposta.body)['token']);
      return true;
    }else{
      print(jsonDecode(resposta.body));
      return false;
    }
  }

}
