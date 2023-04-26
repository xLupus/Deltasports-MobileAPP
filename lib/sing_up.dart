import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();

  String? _nomeController;
  setName(String value) => _nomeController = value;

  String? _emailController;
  setEmail(String value) => _emailController = value;

  String? _senhaController;
  setSenha(String value) => _senhaController = value;

  String? _cpfController;
  setCpf(String value) => _cpfController = value;

  String? _confirmPasswordController;
  setConfirmPassword(String value) => _confirmPasswordController = value;

  final snackBar = SnackBar(
    content: const Text(
      'Usuario já cadastrado',
      textAlign: TextAlign.center,
    ),
    backgroundColor: GlobalColors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: Form(        
        key: _formkey,
        child: Center(
          child: Column(children: [
            Image.network('https://i.imgur.com/aSEadiB.png'),
            const SizedBox(height: 25),

            //Registre-se
            Container(
              child: const Align(
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

            const SizedBox(height: 10),

            Container(
              child: const Align(
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

            const SizedBox(height: 10),

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
                    onChanged: setName,
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Por favor, digite um nome';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            //CPF
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
                    onChanged: setCpf,
                    validator: (cpf) {
                      if (cpf == null || cpf.isEmpty) {
                        return 'Por favor, digite seu CPF';
                      } else if (!RegExp(r"([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})")
                          .hasMatch(_cpfController.toString())) {
                        return 'Por favor, digite um CPF correto';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

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
                    onChanged: setEmail,
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
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

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
                    onChanged: setConfirmPassword,
                    validator: (confsenha) {
                      if (confsenha == null || confsenha.isEmpty) {
                        return 'Por favor, confirme sua senha';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Senha',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //Btn entrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () {
                  var validated = _formkey.currentState!.validate();
                  if (validated && _confirmarSenha(_formkey)) {
                    registrar();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GlobalColors.red,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 5), // changes position of shadow
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

            const SizedBox(height: 20),

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
    final url = Uri.parse('http://127.0.0.1:8000/api/auth/register');

    var resposta = await client.post(url, body: {
      'name': _nomeController,
      'email': _emailController,
      'password': _senhaController,
      'password_confirmation': _confirmPasswordController,
      'cpf': _cpfController,
    });
print(resposta);
    if (resposta.statusCode == 200) {
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

  bool _confirmarSenha(GlobalKey<FormState> _formKey) {    
    if (_senhaController != _confirmPasswordController) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('As senhas não correspondem.'),
      ));
      return false;
    } else {
      return true;
    }    
  }
}