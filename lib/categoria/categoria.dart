import 'dart:convert';
import 'dart:async';

import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/index/listagem.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import '../partials/footer.dart';
import '../partials/header.dart';
import '../utilis/obter_imagem.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import '../perfil/perfil.dart';
import '../produto/produto.dart';

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
    double screenHeight  = MediaQuery.of(context).size.height;
    
    setState(() { _data = mostrar(widget.id); });

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: screenWidth * 0.8,
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
                        const SizedBox(height: 35),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1 / 1.6
                          ),
                          itemCount: snapshot.data['products'].length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProdutoPage(dados: snapshot.data['products'][index])
                                      )
                                    );
                                  },
                                  child: Container(              
                                    height: 223,
                                    width: 260,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                                        color: const Color(0xFFD9D9D9),
                                        image: DecorationImage(
                                        image: obterImagem(snapshot.data['products'][index]['images']),
                                        fit: BoxFit.fitWidth                                                                            
                                      )                  
                                    )
                                  )
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                           LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                return Container(
                                                  constraints: const BoxConstraints(),
                                                  alignment: Alignment.center,
                                                    child: Text(
                                                    '${snapshot.data['products'][index]['name']}',
                                                    maxLines: 2,                         
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                  )
                                                )
                                              );
                                            }
                                           ),
                                            const SizedBox(height: 3),
                                            LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                return Container(
                                                  constraints: const BoxConstraints(),
                                                  alignment: Alignment.center,
                                                    child: Text(
                                                    intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data['products'][index]['price'])),
                                                    maxLines: 2,                         
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                  )
                                                )
                                              );
                                            }
                                          ),
                                        ]
                                      )
                                    )
                                  ]
                                )
                              ]
                            );
                          },
                        )
                      ]
                    );
                  }
                }
              )
            )
          ),
        )
      ),

      bottomNavigationBar: const Footer(), 
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
