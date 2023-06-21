import 'dart:convert';
import 'package:deltasports_app/categoria/categoria.dart';
import 'package:deltasports_app/produto/produto.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;

import '../partials/footer.dart';
import '../partials/header.dart';
import '../utilis/obter_imagem.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({Key? key}) : super(key: key);

  @override
  State<ProdutosPage> createState() => ProdutosPageState();
}

class ProdutosPageState extends State<ProdutosPage> {
   late Future<dynamic> _data;
   late Future<dynamic> _category;

  @override
  Widget build(BuildContext context) {
    double screenWidth    = MediaQuery.of(context).size.width;
    double screenHeight   = MediaQuery.of(context).size.height;
    
    setState(() { 
      _category = mostrarCategorias();
      _data     = mostrar();
    });

    return Scaffold(
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
                                        'Produtos',
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
                            onTap: () { Navigator.pushNamed(context, '/filtros');},
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
                    ],
                  ),
                  const SizedBox(height: 50),
                  FutureBuilder(
                    future: Future.wait([_category, _data]),
                    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: screenHeight - 315,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFBABABA)
                                  )
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
                                height: screenHeight - 315,
                                child: Center(
                                  child: Text(
                                    snapshot.error.toString().substring(11),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    )
                                  )
                                )
                              )
                            );
                          }
                        );
                      } else {
                        return Column(
                        children: [  
                           SizedBox(
                              height: 66,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: snapshot.data![0].length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 10);
                                },
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                        Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => CategoriaPage(snapshot.data![0][index]['id'])),
                                      );
                                    },
                                    child: Container(
                                       margin: const EdgeInsets.only(bottom: 6),
                                      width: 100,
                                      height: 66,                             
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
                                        child: 
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
                                                              '${snapshot.data![0][index]['name']}',
                                                              style: const TextStyle(
                                                                color: Color(0xFFFFFFFF),
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14
                                                              )
                                                            )
                                                          );
                                                        }
                                                      )
                                                    )
                                                  )
                                                ]
                                              )
                                            
                                          
                                        )
                                      )
                                    );
                                  }
                                )
                              ),
                            
                            const SizedBox(height: 30),
                            GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1 / 1.8
                              ),
                              itemCount: snapshot.data![1].length,
                              itemBuilder: (context, index) {
                                final double priceTotal = double.parse(snapshot.data![1][index]['price']) - double.parse(snapshot.data![1][index]['discount']);
                                                          print(snapshot.data![1][index]);
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProdutoPage(data: snapshot.data![1][index])
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
                                            image: obterImagem(snapshot.data![1][index]['images']),
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
                                                        '${snapshot.data![1][index]['name']}',
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
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return Container(
                                                            constraints: const BoxConstraints(),
                                                            alignment: Alignment.center,
                                                              child: Text(
                                                              intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data![1][index]['price'])),
                                                              maxLines: 2,                         
                                                              textAlign: TextAlign.center,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: priceTotal != double.parse(snapshot.data![1][index]['price']) ? 
                                                                const TextStyle(
                                                                  decoration: TextDecoration.lineThrough,
                                                                  color: Color(0xFF000000),
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 13.5,
                                                                ) 
                                                                : 
                                                                const TextStyle(
                                                                decoration: TextDecoration.none,
                                                                color: Color(0xFF000000),
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16 
                                                              )
                                                            )
                                                        );
                                                      }
                                                    ),
                                                  ),          
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              priceTotal < double.parse(snapshot.data![1][index]['price']) ? 
                                                Row(
                                                  children: [              
                                                    Expanded(
                                                      child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {                      
                                                          return Container(
                                                            constraints: const BoxConstraints(),
                                                            alignment: Alignment.center,
                                                              child: Text(
                                                              intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(priceTotal),
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
                                                  )  
                                                ]
                                              )  : Container(),
                                            ]
                                          )
                                        )
                                      ]
                                    )
                                  ]
                                );
                              }
                            )
                          ]
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
      bottomNavigationBar: const Footer(currentPageIndex: 1)
    );
  }

  Future<List<dynamic>> mostrar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client =  http.Client();
    var url = Uri.parse('http://127.0.0.1:8000/api/products');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await client.get(url, headers: headers);

    print([response.statusCode, sharedPreference.getString("token")]);
     if (response.statusCode == 200) {
      Map<String, dynamic> products = jsonDecode(response.body);      
      return products['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro');
  }

  Future<List<dynamic>> mostrarCategorias() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/categories');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> category = jsonDecode(response.body);
      return category['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro ao retornar as categorias');
  }
}
