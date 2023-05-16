import 'dart:convert' as convert;
import 'package:deltasports_app/produtos.dart';
import 'package:http/http.dart' as http;
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

  String? _emailController;
  setLogin(String value) => _emailController = value;

  String? _senhaController;
  setSenha(String value) => _senhaController = value;

  final snackBar = SnackBar(
    content: const Text(
      'e-mail ou senha são inválidos',
      textAlign: TextAlign.center,
    ),
    backgroundColor: GlobalColors.red,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SingleChildScrollView(
        child: Form(
        key: _formkey,
        child: Center(
          child: Column(children: [
            SizedBox(height: screenWidth * 0.15),
            
            Image.network('https://i.imgur.com/aSEadiB.png'),

            SizedBox(height: screenWidth * 0.1),

            //BemVindo
            Align(
              alignment: Alignment(- screenWidth * 0.195 / 100, 0.0),
              child: const Text(
                'Bem-vindo(a)',
                style: TextStyle(
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            Align(
              alignment: Alignment(- screenWidth * 0.195 / 100, 0.0),
              child: const Text(
                'Faça o login ou cadastre-se para continuar',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.025),

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
                    onChanged: setLogin,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Por favor, digite seu e-mail';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.toString())) {
                        return 'Por favor, digite um e-mail correto';
                      }
                      return null;
                    },
                    initialValue: 'testeT@teste.com',
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

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
                    validator: (senha) {
                      if (senha == null || senha.isEmpty) {
                        return 'Por favor, digite sua senha';
                      }
                      return null;
                    },
                    initialValue: '12345678',
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.183),

            Stack(
                children: [
                  SizedBox(
                    width: screenWidth * 0.75,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [ 
                        ElevatedButton(               
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalColors.red,
                            padding: const EdgeInsets.all(10.0),
                            fixedSize: Size(screenWidth * 0.75, 55.0),
                            textStyle: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                            elevation: 20.0,
                            shadowColor: const Color(0xD2000000),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                          ),
                          onPressed: () {
                             if (_formkey.currentState!.validate()) {
                              login();
                          
                            }
                           }, 
                          child: const Text('Entrar'),
                        ),

                        const SizedBox(height: 40.0),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalColors.white,
                            padding: const EdgeInsets.all(10.0),
                            fixedSize: Size(screenWidth * 0.75, 55.0),
                            foregroundColor: GlobalColors.blue,
                            textStyle: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                            elevation: 20.0,            
                            shadowColor: const Color(0xD2000000),                
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            side: BorderSide(color: GlobalColors.blue, width: 3)
                          ),
                          onPressed: () { Navigator.of(context).pushNamed('/'); }, 
                          child: const Text('Voltar')
                        ),
                      ]
                      
                    )
                  )
                ]
              )
            ]
          )
        ),
      ),
      )
    );
  }

  Future<bool> login() async {
    var client = http.Client();
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/auth/login');

    var resposta = await client.post(url, body: {
      'email': _emailController,
      'password': _senhaController
    });

    if (resposta.statusCode == 200) {
      await sharedPreference.setString(
          'token', "Bearer ${convert.jsonDecode(resposta.body)['authorization']['token']}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProdutosPage()),
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
