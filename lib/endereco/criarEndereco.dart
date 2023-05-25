import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utilis/global_colors.dart';
import '../perfil.dart';
import '../produtos.dart';
import '../carrinho.dart';
import '../index.dart';
import '../listagem.dart';
//CRIA ENDEREÇO
class CriarEnderecoPage extends StatefulWidget {
  const CriarEnderecoPage({Key? key}) : super(key: key);

  @override
  State<CriarEnderecoPage> createState() => CriarEnderecoPageState();
}

class CriarEnderecoPageState extends State<CriarEnderecoPage> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController txtCep = TextEditingController();

  final TextEditingController _logradouroController = TextEditingController();

  setLogradouro(String value)     => _logradouroController;

  String? _complementoController;
  setComplemento(String value)    => _complementoController = value;

  String? _numeroController;
  setNumero(String value)         => _numeroController = value;

  String? _cepController;
  setCEP(String value)            => _cepController = value;

  String? _cidadeController;
  setCidade(String value)         => _cidadeController = value;

  String? _estadoController;
  setEstado(String value)         => _estadoController = value;

  String? _tipoController;
  setTipo(String value)           => _tipoController = value;

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
          child: Shortcuts(
            shortcuts: const <ShortcutActivator, Intent>{
                // Pressing space in the field will now move to the next field.
              SingleActivator(LogicalKeyboardKey.space): NextFocusIntent(),
            },
            child: FocusTraversalGroup(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 50,
                    left: 60,
                    child: Image.network('https://i.imgur.com/ell1sHu.png')
                  ),
                  SizedBox(
                    width: screenWidth,
                    child: Center(
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: () {
                          Form.of(primaryFocus!.context!).save();
                        },
                        key: _formkey,
                        child: Container(
                          width: screenWidth * 0.80,
                          margin: const EdgeInsets.only(top: 150),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(
                                            color: GlobalColors.red, width: 5)
                                          ),
                                        ),
                                        child: const Text(
                                        'Novo Endereço:',
                                          style: TextStyle(
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22
                                          )
                                        )
                                      )
                                    )
                                  )
                                ],
                              ),

                              SizedBox(height: screenHeight * 0.025),

                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      onChanged: setLogradouro,
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
                                      onChanged: setComplemento,
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
                                      onChanged: setNumero,
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
                                      controller: txtCep,
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      onChanged: setCEP,
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
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      onChanged: setCidade,
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
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                      onChanged: setEstado,
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
                                      onChanged: setTipo,
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

                              SizedBox(height: screenHeight * 0.3),

                              Container(
                                margin: const EdgeInsets.only(bottom: 20.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GlobalColors.blue,
                                    padding: const EdgeInsets.all(10.0),
                                    fixedSize: Size(screenWidth * 0.75, 55.0),
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
                              )
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

      //footter
      bottomNavigationBar: NavigationBar(destinations: [
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProdutosPage(),
                ),
              );
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home),
                Text('Home'),
              ],
            )),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListagemPage(foto: {}),
                ),
              );
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.category),
                Text('Produtos'),
              ],
            )),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CarrinhoPage(),
                ),
              );
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_shopping_cart),
                Text('Carrinho'),
              ],
            )),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PerfilPage(),
                ),
              );
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person),
                Text('Perfil'),
              ],
            )),
        TextButton(
          onPressed: () async {
            bool saiu = await sair();
            if (saiu) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const IndexPage(),
                ),
              );
            }
          },
          child: const Text('Sair'),
        ),
      ], backgroundColor: GlobalColors.red),
    );
  }

  Future<bool> criar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client = http.Client();
    final url = Uri.parse('http://127.0.0.1:8000/api/user/address');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };

    var response = await client.post(
      url, 
      body: {
        'name'        : _tipoController,
        'street'      : _logradouroController,
        'number'      : _numeroController,
        'complement'  : _complementoController,
        'zip_code'    : _cepController,
        'city'        : _cidadeController,
        'state'       : _estadoController,
    }, headers: headers);
print(response);
    if (response.statusCode == 201) {
      Map<String, dynamic> r = jsonDecode(response.body);
      print(r);
        // ignore: use_build_context_synchronously
       /*  Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
     */
        return true;
    } else {
      if(response.statusCode == 500) {
          // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      return false;
    }
  }

   Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  Future<bool> buscaCEP() async {
    final cep = txtCep.text;

    var client = http.Client();
    final url = Uri.parse(': viacep.com.br/ws/$cep/json/');
    var response = await client.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);


    if(response.statusCode == 200) {
    _logradouroController.text = data['logradouro'];
        /*  _complementoController!.text = complement;
        _cidadeController = data['localidade'];
        _estadoController = data['uf']; */
    };
    return true;
  }
}