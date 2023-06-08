import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/categoria/categoria.dart';
import 'package:deltasports_app/index/index.dart';
import 'package:deltasports_app/index/listagem.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utilis/global_colors.dart';
import '../partials/footer.dart';
import '../partials/header.dart';
import '../produto/produtos.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({Key? key}) : super(key: key);

  @override
  State<CategoriasPage> createState() => CategoriasPageState();
}

class CategoriasPageState extends State<CategoriasPage> {
  late Future<List<dynamic>> _data;

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
                    child: HeaderTwo(),
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
                                    'Categorias:',
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
                  const SizedBox(height: 35),
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
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => CategoriaPage(snapshot.data![index]['id'])),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 15, bottom: 15),
                                height: 70,                               
                                decoration: BoxDecoration(
                                  color: GlobalColors.blue,
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
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: LayoutBuilder(
                                                  builder: (BuildContext context, BoxConstraints constraints) {
                                                    return FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        '${snapshot.data![index]['name']}',
                                                        style: const TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 24
                                                        )
                                                      )
                                                    );
                                                  }
                                                ),
                                              
                                            ),
                                          )
                                        ]
                                      )
                                    ]
                                  )
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

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  Future<List<dynamic>> mostrar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/categories');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> categories = jsonDecode(response.body);      
      return categories['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro ao retornar as categorias');
  }
}