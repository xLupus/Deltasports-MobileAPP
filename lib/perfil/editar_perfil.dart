import 'dart:convert';
import 'package:deltasports_app/perfil/perfil.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../partials/footer.dart';
import '../partials/header.dart';
import '../utilis/snack_bar.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({Key? key}) : super(key: key);

  @override
  State<EditarPerfilPage> createState() => EditarPerfilPageState();
}

class EditarPerfilPageState extends State<EditarPerfilPage> {
  final _formkey = GlobalKey<FormState>();
  late Future<dynamic> _data;

  TextEditingController nomeController      = TextEditingController();
  TextEditingController emailController      = TextEditingController();

  @override
  void initState() {
    super.initState();
    _data = mostrar();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth  = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: screenWidth * 0.85,
              child: FutureBuilder(
                future: _data,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                            return FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: screenHeight - 58,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFBABABA),
                                ),
                              )
                            )
                          );
                        }
                      );
                  } else if(snapshot.hasError) {
                    return LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: screenHeight - 58,
                                child: Center(
                                child: Text(
                                  snapshot.error.toString().substring(11),
                                    style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  )
                                ),
                              )
                            )
                          );
                        }
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 135,
                          child: HeaderThree(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                              alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: GlobalColors.red,
                                          width: 5
                                        )
                                      )
                                    ),
                                    child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Editar Usuário',
                                          style: TextStyle(
                                            color: Color(0xFF1E1E1E),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22
                                          )
                                        )
                                      );
                                    }
                                  )
                                )  
                              )
                            )
                          ]
                        ),
                        const SizedBox(height: 50),
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
                                        Expanded(
                                          child: TextFormField(
                                            controller: nomeController,
                                            autofocus: true,
                                            keyboardType: TextInputType.text,
                                            validator: (nome) {
                                              if (nome == null || nome.isEmpty) {
                                                return 'Por favor, digite um nome';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              labelText: 'Nome Completo',
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                  
                                    SizedBox(height: screenHeight * 0.025),
                  
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: emailController,
                                            autofocus: true,
                                            validator: (email) {
                                              if (email == null || email.isEmpty) {
                                                return 'Por favor, digite seu e-mail';
                                              } else if (!RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(emailController.text.toString())) {
                                                return 'Por favor, digite um e-mail correto';
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                                labelText: 'E-mail',
                                            ),
                                          )
                                        ),
                                      ]
                                    ),
                  
                                    const SizedBox(height: 50),

                                    SizedBox(
                                      height: screenHeight - 465,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
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
                                              onPressed: () {                                   
                                                Navigator.pop(context);
                                              }, 
                                              child: const Text('Voltar')
                                            ),
                                          ),   
                                                                    
                                          const SizedBox(height: 10),
                                                            
                                          Container(
                                            margin: const EdgeInsets.only(bottom: 20.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: GlobalColors.blue,
                                                padding: const EdgeInsets.all(10.0),
                                                fixedSize: Size(screenWidth * 0.85, 55.0),
                                                foregroundColor: GlobalColors.white,
                                                textStyle: const TextStyle(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.w700
                                                ),
                                                elevation: 20.0,            
                                                shadowColor: const Color(0xD2000000),                
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                                              ),
                                              onPressed: () {   
                                                if (_formkey.currentState!.validate()) {
                                                    editar();
                                                  }
                                               }, 
                                              child: const Text('Salvar')
                                            )
                                          )
                                        ],
                                      ),
                                    )
                                  ]
                                )
                              )
                            )
                          )
                        )
                      ]
                    );
                  }
                }
              )
            )
          )
        )
      ),
      bottomNavigationBar: const Footer(currentPageIndex: 3)
    );
  }

  Future<void> mostrar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    var client = http.Client();

    var url = Uri.parse('http://127.0.0.1:8000/api/user');

    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        nomeController.text = data['data']['name'];
        emailController.text = data['data']['email'];
      });
      return;
    }

    throw Exception('Erro ao carregar dados do Usuario');
  }

  Future<void> editar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client = http.Client();
    var url = Uri.parse('http://127.0.0.1:8000/api/user');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };

    var response = await client.patch(url,
      body: {
        'name': nomeController.text, 
        'email': emailController.text
      },
      headers: headers
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      WidgetsBinding.instance.addPostFrameCallback((_) { 
        snackBar(context, data['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PerfilPage()),
        );
      });
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = json.decode(response.body);

      WidgetsBinding.instance.addPostFrameCallback((_) { snackBar(context, error['message']); });
    }
  }
}
