import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'utilis/global_colors.dart';
import 'perfil.dart';
import 'produtos.dart';
import 'carrinho.dart';
import 'index.dart';
import 'listagem.dart';

class EnderecoPage extends StatefulWidget {
  const EnderecoPage({Key? key}) : super(key: key);

  @override
  State<EnderecoPage> createState() => EnderecoPageState();
}

class EnderecoPageState extends State<EnderecoPage> {
  late Future<List<dynamic>> _data;
    
  @override
  Widget build(BuildContext context) {
    double screenWidth  = MediaQuery.of(context).size.width;
    double screenHeight  = MediaQuery.of(context).size.height;

    setState(() {
      _data = mostrar();
    });

    return Scaffold(
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
                      child: Image.network('https://i.imgur.com/ell1sHu.png'),
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
                                ),
                              ),
                              child: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                return const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Endereços:',
                                    style: TextStyle(
                                      color: Color(0xFF1E1E1E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22
                                    )
                                  )
                                );
                              },
                            ),
                          )  
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                        onTap: () { 
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const CriarEnderecoPage()),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.add,
                            color: GlobalColors.red,
                            size: 36,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  FutureBuilder(
                    future: _data, 
                    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFBABABA)
                                ),
                              )
                            ],
                          ),     
                        );
                      } else if(snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 45),
                                    height: 120,                               
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x6D000000),
                                          offset: Offset(0, 4),
                                          blurRadius: 4
                                        )
                                      ],
                                      border: Border.all(
                                        width: 3,
                                        color: GlobalColors.blue
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(22.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  LayoutBuilder(
                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                      return const FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          'Endereço:',
                                                          style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16
                                                          )
                                                        )
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                              Flexible(
                                                child: LayoutBuilder(
                                                  builder: (BuildContext context, BoxConstraints constraints) {
                                                    return Container(
                                                      margin: const EdgeInsets.only(left: 5.0),
                                                      constraints: const BoxConstraints(),
                                                      child: Align(
                                                        alignment: const Alignment(-1, 0.5),
                                                        child: Text(
                                                          '${snapshot.data![index]['street']}, ${snapshot.data![index]['number']}',                            
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            color: Color(0xFF848484),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      )
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  LayoutBuilder(
                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                      return const FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment: Alignment(-1, 0.5),
                                                        child: Text(
                                                          'CEP:',
                                                          style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16
                                                          )
                                                        )
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                              Flexible(
                                                child: LayoutBuilder(
                                                  builder: (BuildContext context, BoxConstraints constraints) {
                                                    return Container(
                                                      margin: const EdgeInsets.only(left: 5.0),
                                                      constraints: const BoxConstraints(),
                                                      child: Align(
                                                        alignment: const Alignment(-1, 0.5),
                                                        child: Text(
                                                          snapshot.data![index]['zip_code'],                            
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            color: Color(0xFF848484),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      )
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  LayoutBuilder(
                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                      return const FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment: Alignment(-1, 0.5),
                                                        child: Text(
                                                          'Tipo:',
                                                          style: TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16
                                                          )
                                                        )
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                              Flexible(
                                                child: LayoutBuilder(
                                                  builder: (BuildContext context, BoxConstraints constraints) {
                                                    return Container(
                                                      margin: const EdgeInsets.only(left: 5.0),
                                                      constraints: const BoxConstraints(),
                                                      child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          snapshot.data![index]['name'],                            
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            color: Color(0xFF848484),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      )
                                                    );
                                                  },
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  LayoutBuilder(
                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                      return Container(
                                                        margin: const EdgeInsets.only(left: 5.0),
                                                        constraints: const BoxConstraints(),
                                                        child: GestureDetector(
                                                          onTap: () { 
                                                            Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => const CriarEnderecoPage()),
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons.border_color_outlined,
                                                            color: GlobalColors.blue,
                                                            size: 22,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ]
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      }
                    }
                  )
                ],
              ),
            )
          ),
        )
      ) 
    );
  }

    Future<List> mostrar() async {
      SharedPreferences sharedPreference = await SharedPreferences.getInstance();
      final url = Uri.parse('http://127.0.0.1:8000/api/user/addresses');
      final headers = {
        'Authorization': '${sharedPreference.getString("token")}',
        'Content-Type': 'application/json'
      };
      var response = await http.get(url, headers: headers);

      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> addresses = jsonDecode(response.body);      
        return addresses['data']; 
      } else if(response.statusCode == 404) {
        final error = jsonDecode(response.body);
        return error;
      }

      throw Exception('Ocorreu um erro ao retornar os endereços');
  }
}

//CRIA ENDEREÇO
class CriarEnderecoPage extends StatefulWidget {
  const CriarEnderecoPage({Key? key}) : super(key: key);

  @override
  State<CriarEnderecoPage> createState() => CriarEnderecoPageState();
}

class CriarEnderecoPageState extends State<CriarEnderecoPage> {
  final _formkey = GlobalKey<FormState>();

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
                                      onChanged: setLogradouro,
                                      validator: (logradouro) {
                                        if (logradouro == null || logradouro.isEmpty) {
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
                                  onPressed: () { Navigator.of(context).pushNamed('/'); }, 
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
    final url = Uri.parse('http://127.0.0.1:8000/api/user/cart/address');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
      
    var response = await client.post(url, body: {
        'name'        : _tipoController,
        'street'      : _logradouroController,
        'number'      : _numeroController,
        'complement'  : _complementoController,
        'zip_code'    : _cepController,
        'city'        : _cidadeController,
        'state'       : _estadoController,
    });

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
}