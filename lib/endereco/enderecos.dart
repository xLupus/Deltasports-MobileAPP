import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/global_colors.dart';
import '../../utilis/snack_bar.dart';
import '../partials/footer.dart';
import '../partials/header.dart';
import 'criar_endereco.dart';
import 'editar_endereco.dart';

class EnderecoPage extends StatefulWidget {
  const EnderecoPage({Key? key}) : super(key: key);

  @override
  State<EnderecoPage> createState() => EnderecoPageState();
}

class EnderecoPageState extends State<EnderecoPage> {
  late Future<List<dynamic>> _data;
  late int id;

  @override
  Widget build(BuildContext context) {
    double screenWidth  = MediaQuery.of(context).size.width;
    double screenHeight  = MediaQuery.of(context).size.height;
    
    setState(() { _data = mostrar(); });

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: screenWidth * 0.8,
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
                                    'Endereços',
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
                              size: 36
                            )
                          )
                        )
                      )
                    ]
                  ),
                  const SizedBox(height: 30),
                  FutureBuilder(
                    future: _data,
                    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: screenHeight - 259,
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
                                height: screenHeight - 259,
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
                        return  ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 20, bottom: 20),
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
                                  borderRadius: const BorderRadius.all(Radius.circular(22.0))
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
                                                }
                                              )
                                            ]
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
                                                        fontSize: 14
                                                      )
                                                    )
                                                  )
                                                );
                                              }
                                            )
                                          )
                                        ]
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
                                            ]
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
                                                      '${snapshot.data![index]['zip_code'].substring(0, 5)}-${snapshot.data![index]['zip_code'].substring(5)}',                                        
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Color(0xFF848484),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 14
                                                      )
                                                    )
                                                  )
                                                );
                                              }
                                            )
                                          )
                                        ]
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
                                                }
                                              )
                                            ]
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
                                                        fontSize: 14
                                                      )
                                                    )
                                                  )
                                                );
                                              }
                                            )
                                          ),
                                          Column(
                                            children: [
                                              LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return Container(
                                                    padding: const EdgeInsets.only(left: 5.5, right: 5.5),
                                                    constraints: const BoxConstraints(),
                                                    child: GestureDetector(
                                                      onTap: () { 
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => EditarEnderecoPage(snapshot.data![index]['id'])),
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.border_color_outlined,
                                                        color: GlobalColors.blue,
                                                        size: 22
                                                      )
                                                    )
                                                  );
                                                }
                                              )
                                            ]
                                          ),
                                          Column(
                                            children: [
                                              LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return Container(
                                                    padding: const EdgeInsets.only(left: 5.5, right: 5.5),
                                                    constraints: const BoxConstraints(),
                                                    child: GestureDetector(
                                                      onTap: () { 
                                                        showDialog(
                                                          context: context, 
                                                          builder: (BuildContext context) => AlertDialog(
                                                            title: const Text(
                                                              'Aviso!',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold
                                                              )
                                                            ),
                                                            content: const Text('Deseja remover o endereço selecionado ?'),
                                                            actions: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: MaterialButton(
                                                                      onPressed: () => {
                                                                        Navigator.pop(context, 'Sim'),
                                                                        remover(snapshot.data![index]['id'])
                                                                      },                                                      
                                                                      child: const Text('Sim')
                                                                    )
                                                                  ),
                                                                  Expanded(
                                                                    child:  MaterialButton(
                                                                      onPressed: () => Navigator.pop(context, 'Não'),                                                             
                                                                      child: const Text('Não')
                                                                    )
                                                                  )
                                                                ]
                                                              )
                                                            ],
                                                            elevation: 20.0,            
                                                            shadowColor: const Color(0xD2000000),                
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
                                                          )
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: GlobalColors.red,
                                                        size: 22
                                                      )
                                                    )
                                                  );
                                                }
                                              )
                                            ]
                                          )
                                        ]
                                      )
                                    ]
                                  )
                                )
                              );
                            }
                          );    
                      }
                    }
                  )
                ]
              )
            )
          )
        )
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Future<List<dynamic>> mostrar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/user/addresses');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> addresses = jsonDecode(response.body);      
      return addresses['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro ao retornar os endereços');
  }

  Future<void> remover(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/user/address/$id');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      setState(() { _data = mostrar(); });

      Map<String, dynamic> data = jsonDecode(response.body);
      WidgetsBinding.instance.addPostFrameCallback((_) { snackBar(context, data['message']); });

      return;
    } else if(response.statusCode == 404) {
      Map<String, dynamic> data = jsonDecode(response.body);
      WidgetsBinding.instance.addPostFrameCallback((_) { snackBar(context, data['message']); }); 
      
      return;
    }

    throw Exception('Ocorreu um erro ao remover o endereço');
  }
}