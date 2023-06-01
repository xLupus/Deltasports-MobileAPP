import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/endereco/endereco.dart';
import 'package:deltasports_app/index.dart';
import 'package:deltasports_app/listagem.dart';
import 'package:deltasports_app/perfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/global_colors.dart';
import '../../utilis/snack_bar.dart';
import '../produtos.dart';

//TODO: VALIDAÇÕES
class EditarEnderecoPage extends StatefulWidget {
  final int id;
  const EditarEnderecoPage(this.id, {Key? key}) : super(key: key);
  
  @override
  State<EditarEnderecoPage> createState() => EditarEnderecoPageState();
}

class EditarEnderecoPageState extends State<EditarEnderecoPage> {
  final _formkey = GlobalKey<FormState>();
/*  
  TextEditingController txtCep = TextEditingController();

  final TextEditingController _logradouroController = TextEditingController();
 */
  String? _logradouroController;
  setLogradouro(String value)     => _logradouroController = value;

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
              width: screenWidth * 0.8,
              child: Column(
                children: [
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 50),
                      child: GestureDetector(
                        onTap: () { 
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const ProdutosPage())
                          );
                        },
                        child: Image.network('https://i.imgur.com/ell1sHu.png')
                      )
                    )
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
                                    'Editar Endereço:',
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
                    SingleActivator(LogicalKeyboardKey.space): NextFocusIntent()
                    },
                    child: FocusTraversalGroup(
                      child:  Form(
                        autovalidateMode: AutovalidateMode.always,
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

                              const SizedBox(height: 100),

                              WillPopScope(
                              onWillPop: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const EnderecoPage()),
                                    );
                                return true; // Permitir que o app saia quando o botão de voltar for pressionado
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
                                  onPressed: () { editar(widget.id); }, 
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
      bottomNavigationBar: NavigationBar(destinations: [
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdutosPage(),
                ),
              );
            },
            child: Column(
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
            child: Column(
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
                  builder: (context) => CarrinhoPage(),
                ),
              );
            },
            child: Column(
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
                  builder: (context) => PerfilPage(),
                ),
              );
            },
            child: Column(
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
                  builder: (context) => IndexPage(),
                ),
              );
            }
          },
          child: Text('Sair'),
        ),
      ], backgroundColor: GlobalColors.red),
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  Future<void> editar(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client = http.Client();
    final url = Uri.parse('http://127.0.0.1:8000/api/user/address/$id');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };

    var response = await client.patch(
      url, 
      body: {
        'name'        : _tipoController,
        'street'      : _logradouroController,
        'number'      : _numeroController,
        'complement'  : _complementoController,
        'zip_code'    : _cepController,
        'city'        : _cidadeController,
        'state'       : _estadoController,
      }, headers: headers
    );

    if (response.statusCode == 200) {
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
     
    throw Exception('Ocorreu um erro ao atualizar o endereço');
  }
}