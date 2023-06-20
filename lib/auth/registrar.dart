import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import '../partials/header.dart';
import '../utilis/global_colors.dart';
import 'package:http/http.dart' as http;
import '../utilis/snack_bar.dart';
import 'login.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => RegistroPageState();
}

class RegistroPageState extends State<RegistroPage> {
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Center(
            child: SizedBox(
              width: screenWidth * 0.85,
              child: Column(
                children: [
                  const SizedBox(
                    height: 135,
                    child: HeaderOne()
                  ),
                   const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                        alignment: Alignment.centerLeft,
                          child: LayoutBuilder(
                           builder: (BuildContext context, BoxConstraints constraints) {
                             return const FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Text(
                                    'Registre-se',
                                    style: TextStyle(
                                      color: Color(0xFF3D3D3D),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24
                                    )
                                  )
                              );
                            }
                          )  
                        )
                      ),
                    ]
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                        alignment: Alignment.centerLeft,
                          child: LayoutBuilder(
                           builder: (BuildContext context, BoxConstraints constraints) {
                             return const FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Text(
                                  'Crie uma nova conta',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16
                                  )
                                )
                              );
                            }
                          )  
                        )
                      ),
                    ]
                  ),
                  const SizedBox(height: 30),
                  Shortcuts(
                          shortcuts: const <ShortcutActivator, Intent> {
                        // Pressing space in the field will now move to the next field.
                          SingleActivator(LogicalKeyboardKey.enter): NextFocusIntent()
                          },
                          child: FocusTraversalGroup(
                            child:  Form(
                              key: _formkey,
                              child: SizedBox(
                                width: screenWidth * 0.85,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 85,
                                          width: screenWidth * 0.85,
                                          child: TextFormField(
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
                                          )
                                        ),
                                      ],
                                    ),
                  
                                    SizedBox(height: screenHeight * 0.001),
                  
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 85,
                                          width: screenWidth * 0.85,
                                          child: TextFormField(
                                            onChanged: setCpf,
                                            validator: (cpf) {
                                              if (cpf == null || cpf.isEmpty) {
                                                return 'Por favor, digite seu CPF';
                                              } else if (!RegExp(
                                                  r"([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})")
                                                  .hasMatch(_cpfController.toString())) {

                                                return 'Por favor, digite um CPF correto';
                                              }
                                              
                                            return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            maxLength: 11,
                                            //inputFormatters: [cpfFormatter],
                                            decoration: const InputDecoration(
                                              labelText: 'CPF',
                                            ),
                                          )
                                        ),
                                      ]
                                    ),

                                    SizedBox(height: screenHeight * 0.001),
                  
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 85,
                                          width: screenWidth * 0.85,
                                          child: TextFormField(
                                            onChanged: setEmail,
                                            validator: (email) {
                                              if (email == null || email.isEmpty) {
                                                return 'Preencha este campo';
                                              } else if (!RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(_emailController.toString())) {
                                                return 'O E-mail informado é inválido';
                                              }

                                              return null;
                                            },
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                              labelText: 'Email'
                                            ),
                                          )
                                        ),
                                      ]
                                    ),

                                    SizedBox(height: screenHeight * 0.001),
                  
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 85,
                                          width: screenWidth * 0.85,
                                          child: TextFormField(
                                            onChanged: setSenha,
                                            validator: (senha) {
                                              if (senha == null || senha.isEmpty) {
                                                return 'Preencha este campo';
                                              }
                                              return null;                                  
                                            },
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              labelText: 'Senha',
                                            )
                                          )
                                        ),
                                      ]
                                    ),

                                    SizedBox(height: screenHeight * 0.001),
                  
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 85,
                                          width: screenWidth * 0.85,
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
                                          )
                                        ),
                                      ]
                                    ),
                            ]
                           )
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 50),

                                    SizedBox(
                                      height: screenHeight - 740,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 20.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: GlobalColors.red,
                                                foregroundColor: GlobalColors.white,
                                                padding: const EdgeInsets.all(10.0),
                                                fixedSize: Size(screenWidth * 0.85, 55.0),
                                                textStyle: const TextStyle(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                elevation: 20.0,
                                                shadowColor: const Color(0xD2000000),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                                              ),
                                              onPressed: () { 
                                                if (_formkey.currentState!.validate() && confirmarSenha(_formkey)) registrar();
                                              },
                                              child: const Text('Registrar'),
                                            ),
                                          ),   
                                                                    
                                          const SizedBox(height: 10),
                                                            
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 20.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: GlobalColors.white,
                                                padding: const EdgeInsets.all(10.0),
                                                fixedSize: Size(screenWidth * 0.85, 55.0),
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
                                        ]
                                      )
                                    ),
                                    const SizedBox(height: 27),
                ],              
              )
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registrar() async {
    var client = http.Client();
    final url = Uri.parse('http://127.0.0.1:8000/api/auth/register');

    var response = await client.post(url, body: {
      'name'                  : _nomeController,
      'email'                 : _emailController,
      'password'              : _senhaController,
      'password_confirmation' : _confirmPasswordController,
      'cpf'                   : _cpfController,
    });

    if (response.statusCode == 200) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );  
      });   
    } else if(response.statusCode == 500) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        snackBar(context, 'Ocorreu um erro ao processar os dados');  
      });
    }
  }

  bool confirmarSenha(GlobalKey<FormState> formKey) {
    
    if (_senhaController != _confirmPasswordController) {
      snackBar(context, 'As senhas informadas não correspondem');
       return false;
    } else {
      return true;
    }
   
  }
}