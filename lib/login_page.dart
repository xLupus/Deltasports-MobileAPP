import 'dart:convert' as convert;
import 'dart:convert';
import 'package:deltasports_app/produtos.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
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
          child: Shortcuts(
            shortcuts: const <ShortcutActivator, Intent>{
                  // Pressing space in the field will now move to the next field.
                SingleActivator(LogicalKeyboardKey.space): NextFocusIntent(),
            },
            child: FocusTraversalGroup(
              child: Center(
                child:  FractionallySizedBox(
                widthFactor: 0.8,  
                child: Stack(
                    children: [         
                      Container(
                        height: screenHeight,
                      ), 
                      SizedBox(
                        width: screenWidth,
                        child: Image.network('https://i.imgur.com/aSEadiB.png'),
                      ),
                      SizedBox(
                        child: Form(
                          key: _formkey,
                          child:  Container(
                            margin: const EdgeInsets.only(top: 250),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Bem-vindo(a)',
                                    style: TextStyle(
                                      color: Color(0xFF3D3D3D),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24
                                    )
                                  )
                                ),

                                SizedBox(height: screenHeight * 0.01),

                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Faça o login ou cadastre-se para continuar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16
                                    )
                                  )
                                ),

                                SizedBox(height: screenHeight * 0.025),

                                TextFormField(
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
                                  initialValue: 'testeT@teste.com',
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'Email'
                                  )
                                ),

                                const SizedBox(height: 18),

                                //Senha
                                TextFormField(
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
                              ]
                            )
                          )
                        )
                      ),
                      Positioned(
                        bottom: 20,
                        child: SizedBox(
                          child: Column(
                            children: [
                            ElevatedButton(               
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: isLoading ? const Color(0xFF919191) : GlobalColors.red,
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
                                child: isLoading ? const SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFBABABA)
                                  ),
                                ) : const Text('Entrar'),
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
    var data = jsonDecode(response.body);
  print(convert.jsonDecode(response.body));
print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        await sharedPreference.setString('token', "Bearer ${convert.jsonDecode(response.body)['authorization']['token']}");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProdutosPage()),
          );
        });
        break;

      case 422:
        /* if(data['message']['password'] != null) {
          senhaMsg = data['message']['password'][0]; // Armazena a mensagem de erro da API
        } */
        break;

      case 401:
        snackBar('E-mail ou senha estão incorretos');  
        break;

      default:
        snackBar('Ocorreu um erro ao processar os dados');
        break;
    }
    
    setState(() {
      isLoading = false;
    });
  }
  
  Future<void> snackBar(txt) async {
    if(!show) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), 
              topRight: Radius.circular(20.0)
            )
          ),
          content: Text(
            txt,
            textAlign: TextAlign.center,
          ),
          backgroundColor: GlobalColors.red,
        )
      ).closed.then((value) {
        show = false;
      });
    }
    show = true;
  }
}
