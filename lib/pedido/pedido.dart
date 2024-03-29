import 'dart:convert';
import 'dart:async';

import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/index/listagem.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;

import 'package:http/http.dart' as http;

import '../partials/footer.dart';
import '../partials/header.dart';
import '../perfil/perfil.dart';
import '../utilis/obter_imagem.dart';

class PedidoPage extends StatefulWidget {
  final int id;
  const PedidoPage(this.id, {Key? key}) : super(key: key);

  @override
  State<PedidoPage> createState() => PedidoPageState();
}

class PedidoPageState extends State<PedidoPage> {
  late Future<dynamic> _data;

  double frete  = 0;
  int val       = 700;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    setState(() { _data = mostrar(widget.id); });

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: SizedBox(
                 width: screenWidth * 0.85,
                  child: FutureBuilder(
                    future: _data,
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
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
                        } else if (snapshot.hasError) {                         
                            return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
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
                                    )
                                  )
                                )
                              );
                            }
                          );
                        } else {
                          while(snapshot.data['total_price'] > val) {
                            val += 700;
                            frete += 7.37;
                          }

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
                                    return Column( 
                                        children: [
                                          Row(
                                            children: [
                                             Expanded(
                                              child:  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                                  return FittedBox( 
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                        'Subtotal: ${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(snapshot.data['total_price'])}',
                                                        style: const TextStyle(
                                                          color: Color(0xFF1E1E1E),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12
                                                        )
                                                      )
                                                    );
                                                  }
                                                ),
                                             )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                              return FittedBox( 
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                    'Total: ${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(snapshot.data['total_price'] + frete)}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF1E1E1E),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16
                                                    )
                                                  )
                                                );
                                              }
                                            ),
                                              )
                                            ],
                                          ),
                                         
                                        ],
                                      );
                                    }
                                  ),
                                  
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
                                                      intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(frete),                            
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
                                        final double priceTotal = double.parse(snapshot.data['items'][index]['product']['price']) - double.parse(snapshot.data['items'][index]['product']['discount']);

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
                                                    return Container(              
                                                      height: 106,
                                                      width: 106,
                                                      decoration: 
                                                      BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                                                          color: const Color(0xFFE5E5E5),
                                                          image: DecorationImage(
                                                          image: obterImagem(snapshot.data['items'][index]['product']['images']),
                                                          fit: BoxFit.fitWidth                                                                            
                                                        )                   
                                                      ),
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
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: LayoutBuilder(
                                                            builder: (BuildContext context, BoxConstraints constraints) {
                                                              return Container(
                                                                constraints: const BoxConstraints(),
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data['items'][index]['product']['price'])),                
                                                                    overflow: TextOverflow.ellipsis,
                                                                     style: priceTotal != double.parse(snapshot.data['items'][index]['product']['price']) ? 
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
                                                           priceTotal < double.parse(snapshot.data['items'][index]['product']['price']) ? 
                                                          Expanded(
                                                            child: LayoutBuilder(
                                                            builder: (BuildContext context, BoxConstraints constraints) {
                                                              return Container(
                                                                constraints: const BoxConstraints(),
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(priceTotal),                
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: const TextStyle(
                                                                      color: Color(0xFF000000),
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 16
                                                                    )
                                                                  )
                                                                );
                                                              }
                                                            )
                                                          ) : Container(),
                                                        
                                                      ],
                                                    )
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
                                                  width: 83,    
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
      bottomNavigationBar: const Footer()
    );
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
