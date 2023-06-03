import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/index.dart';
import 'package:deltasports_app/listagem.dart';
import 'package:deltasports_app/perfil.dart';
import 'package:deltasports_app/utilis/get_cep.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/global_colors.dart';
import '../../utilis/snack_bar.dart';
import '../produtos.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({Key? key}) : super(key: key);

  @override
  State<PedidosPage> createState() => PedidosPageState();
}

class PedidosPageState extends State<PedidosPage> {
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
                                    'Meus Pedidos:',
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
                                height: screenHeight - 304,
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
                                height: screenHeight - 304,
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
                                            width: 94, // usa a largura máxima disponível
                                            height: 94, // usa a altura máxima disponível
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE5E5E5),
                                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                            ),
                                            child: Column(
                                              children: [
                                                const Expanded(
                                                  child: Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Text(
                                                      'Pedido',
                                                      style: TextStyle(
                                                        color: Color(0xFF656565),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.topCenter,
                                                    child: Text(
                                                      snapshot.data![index]['PEDIDO_ID'] < 100  ? '#00${snapshot.data![index]['PEDIDO_ID']}' : '#0${snapshot.data![index]['PEDIDO_ID']}' ,
                                                      style: const TextStyle(
                                                        color: Color(0xFF656565),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
 
                                    const Spacer(),
                                    Expanded(
                                      flex: 6,
                                      child: LayoutBuilder(
                                        builder: (BuildContext context, BoxConstraints constraints) {
                                          return Container(

                                            constraints: const BoxConstraints(),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Mochila 1, Mochila 2, Mochila 3',   
                                              maxLines: 3,                         
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color(0xFF848484),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                              )
                                            )
                                          );
                                        }
                                      )
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 94,
                                      child: Column(              
                                        children: [
                                           Expanded(
                                            child: LayoutBuilder(
                                            builder: (BuildContext context, BoxConstraints constraints) {
                                              return Container(
                                                constraints: const BoxConstraints(),
                                                alignment: Alignment.bottomRight,
                                                child: const Text(
                                                  'R\$ 1200,00',   
                                                  maxLines: 2,                         
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Color(0xFF1E1E1E),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                  )
                                                )
                                              );
                                            }
                                            )
                                          ),
                                     
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                         Navigator.of(context).pushNamed('/Pedido');
                                                      },
                                                      child: SizedBox(
                                                      height: 20,
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.visibility_outlined,
                                                              color: GlobalColors.blue,
                                                              size: 20
                                                            ),
                                                            const SizedBox(width: 5),
                                                            const Text(
                                                              'Ver Pedido',  
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                color: Color(0xFF848484),
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 10
                                                              )
                                                            )
                                                          ]
                                                        )
                                                      ),
                                                    )
                                                  );
                                                }
                                              )
                                            )
                                          )       
                                        ]
                                      )
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
              Navigator.pushReplacementNamed(
                context,
                '/Perfil'
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person),
                Text('Perfil'),
              ],
            )),
       
      ], backgroundColor: GlobalColors.red), 
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  Future<List<dynamic>> mostrar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/orders');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await http.get(url, headers: headers);

      print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> orders = jsonDecode(response.body);      
      return orders['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro ao retornar os pedidos');
  }
}