import 'dart:convert';
import 'dart:async';

import 'package:deltasports_app/auth/login_page.dart';
import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/index/listagem.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../perfil/perfil.dart';

class CategoriaPage extends StatefulWidget {
  final int id;
  const CategoriaPage(this.id, {Key? key}) : super(key: key);

  @override
  State<CategoriaPage> createState() => CategoriaPageState();
}

class CategoriaPageState extends State<CategoriaPage> {
  late Future<dynamic> _data;

  @override
  Widget build(BuildContext context) {
    double screenWidth  = MediaQuery.of(context).size.width;
    
    setState(() {_data = mostrar(widget.id); });

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.8,
            child: FutureBuilder(
              future: _data, 
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(  
                    child: CircularProgressIndicator(
                      color: Color(0xFFBABABA),
                    ),
                  );
                } else if(snapshot.hasError) {
                  return Center(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            snapshot.error.toString().substring(11),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            )
                          )
                        );
                      }
                    )
                  );
                } else {
                  return Column(
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
                                    return FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${snapshot.data['category']['name']}',
                                        style: const TextStyle(
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
                    ]
                  );
                }
              }
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
            ))
      ], backgroundColor: GlobalColors.red),
    );
  }

  Future<Map<String, dynamic>> mostrar(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/category/$id/products');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> products = jsonDecode(response.body);      
      return products['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro ao retornar as categorias');
  }
}
