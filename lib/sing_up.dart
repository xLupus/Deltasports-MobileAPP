import 'package:flutter/material.dart';

import 'dart:convert';
import 'utilis/global_colors.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var _nameError = '';
  dynamic data = '';
  var nomeMsg = '';
  var emailMsg = '';
  var senhaMsg = '';
  var confSenhaMsg = '';
  var cpfMsg = '';
  var error = '';

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
        'Ocorreu um erro',
        textAlign: TextAlign.center,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
    ),
    backgroundColor: GlobalColors.red
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:  SizedBox(
            height: screenHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight < 800 ? screenHeight * 0.3 : screenHeight * 0.07),

                      Image.network('https://i.imgur.com/aSEadiB.png'),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child:  Container(
                    width: screenWidth * 0.75,
                    margin: const EdgeInsets.only(top: 250),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Registre-se',
                            style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.01),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Crie uma nova conta.',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.025),

                          TextFormField(
                            onChanged: setName,
                            validator: (nome) {
                              if (nome == null || nome.isEmpty) {
                                return 'Preencha este campo';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Nome'
                            )
                          ),

                          SizedBox(height: screenHeight * 0.025),

                          TextFormField(
                            onChanged: setCpf,
                            validator: (cpf) {
                              if (cpf == null || cpf.isEmpty) {
                                return 'Por favor, digite seu CPF';
                              } else if (!RegExp(
                                  r"([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})")
                                  .hasMatch(_cpfController.toString())) {

                                if(cpfMsg != '') {
                                  return cpfMsg;
                                }

                                return 'Por favor, digite um CPF correto';
                              }
                              
                            return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'CPF',
                            ),
                          ),
                    
                        SizedBox(height: screenHeight * 0.025),

                        TextFormField(
                          onChanged: setEmail,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Preencha este campo';
                            } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(_emailController.toString())) {
                              return 'O E-mail informado é inválido';
                            }
                 
                              if(emailMsg != '') {
                                return emailMsg;
                              }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email'
                          ),
                        ),
                    
                        SizedBox(height: screenHeight * 0.025),

                        TextFormField(
                          onChanged: setSenha,
                          validator: (senha) {
                            if (senha == null || senha.isEmpty) {
                              return 'Preencha este campo';
                            }
                            if(senhaMsg != '') {
                              return senhaMsg;
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.025),

                      TextFormField(
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
                      ]
                    )
                  )
                ),
                Positioned(
                  bottom: 20,
                  child: SizedBox(
                    width: screenWidth * 0.75,
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
                            if (formKey.currentState!.validate() && _confirmarSenha(formKey)) registrar();
                          },
                          child: const Text('Registrar'),
                        ),
                        
                        SizedBox(height: screenHeight * 0.045),

                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: ElevatedButton(
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
                        )
                      ],
                    ),
                  )
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> registrar() async {
    var client = http.Client();
    final url = Uri.parse('http://127.0.0.1:8000/api/user/cart/address');

    var resposta = await client.post(url, body: {
      'name': _nomeController,
      'email': _emailController,
      'password': _senhaController,
      'password_confirmation': _confirmPasswordController,
      'cpf': _cpfController,
    });

    if (resposta.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
  
      return true;
    } else {
      // ignore: use_build_context_synchronously
      if(resposta.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      data = jsonDecode(resposta.body);
      
      if(data['message']['name'] != null) {
        nomeMsg = data['message']['name'][0];
      } 
     
      if(data['message']['email'] != null) {
         emailMsg = data['message']['email'][0];
      } 

      if(data['message']['password'] != null) {
        senhaMsg = data['message']['password'][0];
      }

      if(data['message']['confirm_password'] != null) {
        confSenhaMsg = data['message']['namconfirm_password'][0];
      }

      if(data['message']['cpf'] != null) {
        cpfMsg = data['message']['cpf'][0];
      }
      
      return false;
    }
  }

  bool _confirmarSenha(GlobalKey<FormState> formKey) {
    if (_senhaController != _confirmPasswordController) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('As senhas informadas não correspondem.', textAlign: TextAlign.center),
        backgroundColor: GlobalColors.red,
      ));
      return false;
    } else {
      return true;
    }
  }
}

