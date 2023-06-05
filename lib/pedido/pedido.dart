import 'dart:convert';
import 'dart:async';

import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/listagem.dart';
import 'package:deltasports_app/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;

import 'package:http/http.dart' as http;

import '../perfil.dart';

class PedidoPage extends StatefulWidget {
  final int id;
  const PedidoPage(this.id, {Key? key}) : super(key: key);

  @override
  State<PedidoPage> createState() => PedidoPageState();
}

class PedidoPageState extends State<PedidoPage> {
  late Future<dynamic> _data;

  bool isLoading  = false;
  dynamic name    = '';
  dynamic email   = '';
  double frete       = 0;
  int val         = 700;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      _data = mostrar(widget.id);
    });

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
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                              return FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: screenHeight - 80,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFBABABA),
                                    ),
                                  )
                                )
                              );
                            }
                          );
                        } else if (snapshot.hasError) {                         
                            return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                              return FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: screenHeight - 80,
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
                          while(snapshot.data['total_price'] > val) {
                            val += 700;
                            frete += 8;
                          }

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
                                      MaterialPageRoute(
                                      builder: (context) => const ProdutosPage()
                                    )
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
                                      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                        return FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.center,
                                          child: Text(
                                              'Pedido: ${snapshot.data['id'] < 100 ? '#00${snapshot.data['id']}' : '#0${snapshot.data['id']}'}',
                                              style: const TextStyle(
                                                color:Color(0xFF1E1E1E),
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
                                  child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                    return FittedBox( 
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          'Total: ${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(snapshot.data['total_price'])}',
                                          style: const TextStyle(
                                            color: Color(0xFF1E1E1E),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                          )
                                        )
                                      );
                                    }
                                  )
                                ),
                              ]
                            ),
                            const SizedBox(height: 30),
                            Container(
                              margin: const EdgeInsets.only(top: 20, bottom: 20),
                              height: 156,
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
                                          Flexible(
                                            child: LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return const FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.centerLeft,
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
                                              ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                return Container(
                                                  margin: const EdgeInsets.only(left: 5.0),
                                                  constraints: const BoxConstraints(),
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      '${snapshot.data['address']['street']}, ${snapshot.data['address']['number']}',                            
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
                                        ],
                                    ),

                                    const Spacer(),

                                    Row(
                                      children: [
                                          Flexible(
                                            child: LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return const FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'CEP:',
                                                      style: TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16
                                                      )
                                                    )
                                                  );
                                                }
                                              ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                return Container(
                                                  margin: const EdgeInsets.only(left: 5.0),
                                                  constraints: const BoxConstraints(),
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      '${snapshot.data['address']['zip_code']}',                            
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
                                        ],
                                    ),

                                    const Spacer(), 

                                    Row(
                                      children: [
                                          Flexible(
                                            child: LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return const FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Frete:',
                                                      style: TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16
                                                      )
                                                    )
                                                  );
                                                }
                                              ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                return Container(
                                                  margin: const EdgeInsets.only(left: 5.0),
                                                  constraints: const BoxConstraints(),
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'R\$ $frete,00',                            
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
                                        ],
                                    ),

                                    const Spacer(), 

                                    Row(
                                      children: [
                                          Flexible(
                                            child: LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return const FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Entrega:',
                                                      style: TextStyle(
                                                        color: Color(0xFF000000),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16
                                                      )
                                                    )
                                                  );
                                                }
                                              ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                return Container(
                                                  margin: const EdgeInsets.only(left: 5.0),
                                                  constraints: const BoxConstraints(),
                                                  child: const Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      '2 à 5 dias',                            
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
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
                                  ]
                                )
                            )
                          ),
                          const SizedBox(height: 20),
                          ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data['items'].length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                                          height: 130,                               
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
                                              color: Colors.transparent
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(22.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [                  
                                                  LayoutBuilder(
                                                    builder: (context, constraints) {
                                                      return ClipRRect(
                                                        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                                                        child: Container(
                                                          height: 106,
                                                          width: 106,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                image: obterImagem(snapshot.data['items'][index]['product']['images']),
                                                                fit: BoxFit.cover
                                                            )
                                                          )
                                                        )
                                                      );
                                                    }
                                                  ),
            
                                                const Spacer(),
                                                Flexible(
                                                  flex: 7,
                                                  child: LayoutBuilder(
                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                      return Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: LayoutBuilder(
                                                            builder: (BuildContext context, BoxConstraints constraints) {
                                                              return Container(
                                                                constraints: const BoxConstraints(),
                                                                alignment: Alignment.centerLeft,
                                                                child: Text(
                                                                  '${snapshot.data['items'][index]['product']['name']}',
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    color: Color(0xFF000000),
                                                                    height: 1.15,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 16
                                                                  )
                                                                )
                                                              );
                                                            }
                                                          ),
                                                    ),
                                                   const Spacer(),
                                                   Expanded(
                                                    flex: 4,
                                                    child:  LayoutBuilder(
                                                          builder: (BuildContext context, BoxConstraints constraints) {
                                                            return Container(
                                                              constraints: const BoxConstraints(),
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                '${snapshot.data['items'][index]['product']['description']}',   
                                                                maxLines: 2,                         
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                  color: Color(0xFF848484),
                                                                  fontWeight: FontWeight.w400,
                                                                  height: 1.15,
                                                                  fontSize: 12
                                                                )
                                                              )
                                                            );
                                                          }
                                                        ),
                                                   ),
                                                  const Spacer(),
                                                   Expanded(
                                                    flex: 3,
                                                    child: LayoutBuilder(
                                                          builder: (BuildContext context, BoxConstraints constraints) {
                                                            return Container(
                                                              constraints: const BoxConstraints(),
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data['items'][index]['product']['price'])),                
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
                                                  ],
                                                );
                                                    }
                                                  )
                                                ),
                                                
                                                const Spacer(),
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: SizedBox(
                                                   height: 35,
                                                  width: 8git 3,    
                                                        child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return Container(                                            
                                                            decoration: const BoxDecoration(
                                                              color: Color(0x991C8394),
                                                              borderRadius: BorderRadius.all(Radius.circular(12.0))
                                                            ),
                                                            constraints: const BoxConstraints(),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              snapshot.data['items'][index]['qtd'] < 10 ? '0${snapshot.data['items'][index]['qtd']}' : '${snapshot.data['items'][index]['qtd']}',                 
                                                              textAlign: TextAlign.center,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                color: GlobalColors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16
                                                              )
                                                            )
                                                          );
                                                        }
                                                        )
                                                      ),
                                                )
                                              ]
                                            )
                                          )
                                        );
                                      }
                                    )
                        ]
                      );
                    }
                  }
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
            ))
      ], backgroundColor: GlobalColors.red),
    );
  }

  dynamic obterImagem(dynamic url) {
      print(url);
      if (url.length > 0 && url[0] != null && url[0]['url'] != '') {//['items'][0]['product']['images'][0]['url']
        return NetworkImage(url[0]['url']);
      } else {
        return const AssetImage('images/no_image.png');
      }
    }

  Future<Map<String, dynamic>> mostrar(int id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/order/$id');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> order = jsonDecode(response.body);

      return order['data'];
    } else if (response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro ao retornar os pedidos');
  }
}
