import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formkey = GlobalKey<FormState>();

  String? _emailController;
  setLogin(String value) => _emailController = value;

  String? _senhaController;
  setSenha(String value) => _senhaController = value;

  final _confirmarSenhaController = TextEditingController();
  final _cpfController = TextEditingController();

  final snackBar = SnackBar(
    content: Text(
      'Usuario já cadastrado',
      textAlign: TextAlign.center,
    ),
    backgroundColor: GlobalColors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Image.network('https://i.imgur.com/aSEadiB.png'),
            SizedBox(height: 25),

            //Registre-se
            Container(
              child: Align(
                alignment: Alignment(-0.75, 0.0),
                child: Text(
                  'Registre-se',
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
                alignment: Alignment(-0.75, 0.0),
                child: Text(
                  'Crie uma nova conta.',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            //Nome
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
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 18),

            //CPF
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () =>
                    {Navigator.of(context).pushReplacementNamed('/Login')},
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: _cpfController,
                      validator: (cpf){
                        if(cpf == null || cpf.isEmpty){
                          return 'Por favor, digite seu CPF';
                        }else if (!RegExp(
                            r"^[/^\d{3}\.\d{3}\.\d{3}-\d{2}$/]+")
                        .hasMatch(_cpfController.text)) {
                      return 'Por favor, digite um CPF correto';
                    }
                    return null;
                    },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'CPF',
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 18),

            //Email
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
                    onChanged: setLogin,
                    validator: (email){
                      if(email == null || email.isEmpty){
                        return 'Por favor, digite seu e-mail';
                      }else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.toString())) {
                      return 'Por favor, digite um e-mail correto';
                    }
                    return null;
                    },
                    keyboardType: TextInputType.emailAddress,
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
                    onChanged: setSenha,
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

            SizedBox(height: 18),

            //Senha Confirmar
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
                    controller: _confirmarSenhaController,
                    validator: (confirmarSenha){

                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Senha',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            //Btn entrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (_formkey.currentState!.validate()) {
                    registrar();
                    if (!currentFocus.hasFocus) {
                      currentFocus.unfocus();
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GlobalColors.red,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
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
                      'Entrar',
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

            SizedBox(height: 20),

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
                    boxShadow: [
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

  Future<bool> registrar() async {
    var client = http.Client();
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/auth/register');

    var resposta = await client.post(url, body: {
      'email': _emailController,
      'password': _senhaController
    });

    if (resposta.statusCode == 200) {
      await sharedPreference.setString(
          'token', "Token ${convert.jsonDecode(resposta.body)['token']}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );

      print(convert.jsonDecode(resposta.body));

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(convert.jsonDecode(resposta.body));
      return false;
    }
  }
  
}


/*
void _submitForm() {
  if (_formKey.currentState.validate()) {
    final senha = _passwordController.text;
    final confirmarSenha = _confirmPasswordController.text;
    if (senha != confirmarSenha) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('As senhas não correspondem.'),
      ));
    } else {
      // As senhas correspondem, faça algo com os valores aqui.
    }
  }
}
*/