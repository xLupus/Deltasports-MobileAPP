import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../partials/header.dart';
import '../utilis/snack_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginPageState();
}

class LoginPageState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  bool show = false;
  bool isLoading = false;
  
  String? _emailController;
  setLogin(String value) => _emailController = value;

  String? _senhaController;
  setSenha(String value) => _senhaController = value;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
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
                                    'Bem-vindo(a)',
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
                                  'Faça o login ou cadastre-se para continuar',
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
                                            onChanged: setLogin,
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
                                            initialValue: 'teste@teste.com',
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                              labelText: 'Email'
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
                                            onChanged: setSenha,
                                            validator: (senha) {
                                              if (senha == null || senha.isEmpty) {
                                                return 'Preencha este campo';
                                              }
                                              return null;                                  
                                            },
                                            initialValue: '12345678',
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              labelText: 'Senha',
                                            )
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
                                      height: screenHeight - 480,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 20.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: isLoading ? const Color(0xFF919191) : GlobalColors.red,
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
                                                  if (_formkey.currentState!.validate()) {
                                                      login();
                                                    }
                                              }, 
                                              child: isLoading ? const SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: CircularProgressIndicator(
                                                  color: Color(0xFFBABABA)
                                                ),
                                              ) : const Text('Entrar'),
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
                                            )
                                          )
                                        ]
                                      )
                                    ),
                                    const SizedBox(height: 27),
                ]
              )
            )
          )
        )
      )
    );
  }

  Future<void> login() async {
    var client = http.Client();
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/auth/login');

    setState(() {
      isLoading = true;
    });
    
    var response = await client.post(url, body: {
      'email'   : _emailController,
      'password': _senhaController
    });

    switch (response.statusCode) {
      case 200:
        await sharedPreference.setString('token', "Bearer ${convert.jsonDecode(response.body)['authorization']['token']}");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
            (route) => false,
          );
        });
        break;

      case 422:
        /* if(data['message']['password'] != null) {
          senhaMsg = data['message']['password'][0]; // Armazena a mensagem de erro da API
        } */
        break;

      case 401:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          snackBar(context, 'E-mail ou senha estão incorretos');  
        });       
        break;

      default:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          snackBar(context, 'Ocorreu um erro ao processar os dados');  
        });
        setState(() {  isLoading = false; });
        break;
    }
    
    setState(() {
      isLoading = false;
    });
  }
}
