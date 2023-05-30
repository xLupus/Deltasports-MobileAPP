import 'package:deltasports_app/endereco/endereco.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/global_colors.dart';
import '../../utilis/snack_bar.dart';
import '../../utilis/get_cep.dart';

import '../produtos.dart';

//TODO: VALIDAÇÕES
class EditarEnderecoPage extends StatefulWidget {
  final int id;
  const EditarEnderecoPage(this.id, {Key? key}) : super(key: key);
  
  @override
  State<EditarEnderecoPage> createState() => EditarEnderecoPageState();
}

class EditarEnderecoPageState extends State<EditarEnderecoPage> {
  final _formkey                                      = GlobalKey<FormState>();
 
  final TextEditingController _logradouroController   = TextEditingController();
  final TextEditingController _complementoController  = TextEditingController();
  final TextEditingController _numeroController       = TextEditingController();
  final TextEditingController _cepController          = TextEditingController();
  final TextEditingController _cidadeController       = TextEditingController();
  final TextEditingController _estadoController       = TextEditingController();
  final TextEditingController _tipoController         = TextEditingController();


  setLogradouro(String value)     => _logradouroController;

  setComplemento(String value)    => _complementoController;

  setNumero(String value)         => _numeroController;

  setCEP(String value)            => _cepController;

  setCidade(String value)         => _cidadeController;

  setEstado(String value)         => _estadoController;

  setTipo(String value)           => _tipoController;

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
                                      controller: _logradouroController,                             
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
                                    child:TextFormField(
                                      controller: _complementoController,
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
                                    child:TextFormField(
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
                                      controller: _cepController,               
                                      keyboardType: TextInputType.number,
                                      onChanged: setCEP,
                                      validator: (cep) {
                                        if (cep == null || cep.isEmpty) {
                                          return 'Preencha este campo';
                                        } else if (!RegExp(r"^[0-9]{8}$").hasMatch(_cepController.toString())) {
                                          return 'Este campo deve conter 8 dígitos';
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
                                    child:TextFormField(
                                      controller: _cidadeController,
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
                                    child: TextFormField(
                                      controller: _estadoController,
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
                                    child: TextFormField(
                                      controller: _tipoController,
                                      keyboardType: TextInputType.text,
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
                                  )
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
                                  onPressed: () { if (_formkey.currentState!.validate()) editar(widget.id); }, 
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
      )
    );
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