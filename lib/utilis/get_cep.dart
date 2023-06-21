import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/index/index.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:deltasports_app/perfil/perfil.dart';

import '../endereco/enderecos.dart';
import '../partials/footer.dart';
import '../partials/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/global_colors.dart';
import '../../utilis/snack_bar.dart';


void main() {
  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {
  @override
  _MeuAppState createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final _formkey = GlobalKey<FormState>();

String? complementoController;
  setComplemento(String value)    => complementoController = value;

  String? numeroController;
  setNumero(String value)         => numeroController = value;

   String? tipoController;
  setTipo(String value)           => tipoController = value;


  TextEditingController cepController         = TextEditingController();
  TextEditingController logradouroController  = TextEditingController();
  TextEditingController cidadeController      = TextEditingController();
  TextEditingController estadoController      = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

   return MaterialApp(
      home: Scaffold(
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
                                    'Novo Endereço:',
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
                        onChanged: () {
                          Form.of(primaryFocus!.context!).save();
                        },
                        key: _formkey,
                        child: SizedBox(
                          width: screenWidth * 0.80,
                          child: Column(
                            children: [
                               
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: logradouroController,
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      validator: (logradouro) {
                                        if (logradouro == null || logradouro.isEmpty) {
                                          return 'Preencha este campo';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Logradouro',
                                      ),
                                    )
                                  ),
                                ],
                              ),

                              SizedBox(height: screenHeight * 0.025),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: TextFormField(
                                      autofocus: true,
                                      validator: (complemento) {
                                        if (complemento == null || complemento.isEmpty) {
                                          return 'Preencha este campo';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'Complemento',
                                      ),
                                    )
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      validator: (numero) {
                                        if (numero == null || numero.isEmpty) {
                                          return 'Preencha este campo';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Nº',
                                      )
                                    )
                                  )
                                ]
                              ),

                              SizedBox(height: screenHeight * 0.025),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: TextFormField(
                                      maxLength: 8,
                                      controller: cepController,
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      validator: (cep) {
                                        if (cep == null || cep.isEmpty) {
                                          return 'Preencha este campo';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'CEP'
                                      ),
                                    )
                                  ),
                                   

                                  const Spacer(),
                                  Expanded(
                                    flex: 4,
                                    child: TextFormField(
                                      controller: cidadeController,
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      validator: (cidade) {
                                        if (cidade == null || cidade.isEmpty) {
                                          return 'Preencha este campo';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Cidade'
                                      ),
                                    )
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 2,
                                    child:  TextFormField(
                                      controller: estadoController,
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      validator: (estado) {
                                        if (estado == null || estado.isEmpty) {
                                          return 'Preencha este campo';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Estado'
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: screenHeight * 0.025),

                              Row(
                                children: [
                                  SizedBox(height: screenHeight * 0.025),
                                  Expanded(
                                    flex: 3,
                                    child:  TextFormField(
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      validator: (tipo) {
                                        if (tipo == null || tipo.isEmpty) {
                                          return 'Preencha este campo';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Tipo'
                                      )
                                    )
                                  )
                                ]
                              ),

                              const SizedBox(height: 50),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GlobalColors.blue,
                                    padding: const EdgeInsets.all(10.0),
                                    fixedSize: Size(200, 55.0),
                                    foregroundColor: GlobalColors.white,
                                    textStyle: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700
                                    ),
                                    elevation: 20.0,            
                                    shadowColor: const Color(0xD2000000),                
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                                  ),
                                  onPressed: buscarDadosCEP, 
                                  child: const Text('Buscar')
                                )
                              ),
                              const SizedBox(height: 20),
                            WillPopScope(
                              onWillPop: () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const EnderecoPage()),
                                );
                                return true;
                              },
                              child:  Container(
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
                                  onPressed: () { 
                                    
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const EnderecoPage()),
                                    );
                                  }, 
                                  child: const Text('Voltar')
                                ),
                              ),   
                            ),
                            const SizedBox(height: 10),

                              Container(
                                margin: const EdgeInsets.only(bottom: 20.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GlobalColors.blue,
                                    padding: const EdgeInsets.all(10.0),
                                    fixedSize: Size(screenWidth * 0.75, 55.0),
                                    foregroundColor: GlobalColors.white,
                                    textStyle: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700
                                    ),
                                    elevation: 20.0,            
                                    shadowColor: const Color(0xD2000000),                
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                                  ),
                                  onPressed: () { criar(); }, 
                                  child: const Text('Salvar')
                                )
                              ),
                            ]
                          )
                        )
                      )
                    )
                  )
                ]
              )
            )
          )
        )
      ),


    )
   );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  Future<void> criar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client = http.Client();
    final url = Uri.parse('http://127.0.0.1:8000/api/user/address');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };
    print({
      logradouroController.text
    });

    var response = await client.post(
      url, 
      body: {
        'name'        : tipoController,
        'street'      : logradouroController,
        'number'      : numeroController,
        'complement'  : complementoController,
        'zip_code'    : cepController,
        'city'        : cidadeController,
        'state'       : estadoController,
      }, headers: headers
    );
    if (response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      WidgetsBinding.instance.addPostFrameCallback((_) { 
        snackBar(context, data['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EnderecoPage()),
        );
      });
      return;
    } else if(response.statusCode == 404)  {
      Map<String, dynamic> data = jsonDecode(response.body);
      WidgetsBinding.instance.addPostFrameCallback((_) { 
        snackBar(context, data['message']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EnderecoPage()),
        );
      });
      return;
    }
     
    throw Exception('Ocorreu um erro ao cadastrar o endereço');
  }

  Future<void> buscarDadosCEP() async {
    try {
      String cep = cepController.text;
      final url = 'https://viacep.com.br/ws/$cep/json/';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> dados = jsonDecode(response.body);

        setState(() {
          logradouroController.text = dados['logradouro'];
          cidadeController.text = dados['localidade'];
          estadoController.text = dados['uf'];
        });
      } else {
        throw Exception('Erro ao buscar CEP');
      }
    } catch (e) {
      // Tratar erro de busca do CEP
    }
  }
}

