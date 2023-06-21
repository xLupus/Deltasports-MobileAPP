import 'package:deltasports_app/pedido/pedido.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilis/global_colors.dart';
import '../partials/footer.dart';
import '../partials/header.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({Key? key}) : super(key: key);

  @override
  State<PedidosPage> createState() => PedidosPageState();
}

class PedidosPageState extends State<PedidosPage> {
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
              width: screenWidth * 0.85,
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
                              margin: const EdgeInsets.only(top: 12, bottom: 12),
                              height: 130,                               
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x6D000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 4
                                  )
                                ],
                                borderRadius: BorderRadius.all(Radius.circular(22.0))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [                  
                                     LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Container(
                                            width: 110, // usa a largura máxima disponível
                                            height: 110, // usa a altura máxima disponível
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE5E5E5),
                                              borderRadius: BorderRadius.all(Radius.circular(14.0)),
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
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.topCenter,
                                                    child: Text(
                                                      snapshot.data![index]['id'] < 100  ? '#00${snapshot.data![index]['id']}' : '#0${snapshot.data![index]['id']}' ,
                                                      style: const TextStyle(
                                                        color: Color(0xFF656565),
                                                        fontSize: 20,
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
                                      flex: 5,
                                      child: LayoutBuilder(
                                        builder: (BuildContext context, BoxConstraints constraints) {
                                          return Container(
                                            constraints: const BoxConstraints(),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${snapshot.data![index]['product']['name']}',   
                                              maxLines: 3,                         
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
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
                                                child: Text(
                                                  intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data![index]['product']['price'])),   
                                                  maxLines: 2,                         
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Color(0xFF1E1E1E),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17
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
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(builder: (context) =>  PedidoPage(snapshot.data![index]['id']))
                                                        );
                                                      },
                                                      child: SizedBox(
                                                      height: 21,
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.visibility_outlined,
                                                              color: GlobalColors.blue,
                                                              size: 21
                                                            ),
                                                            const SizedBox(width: 5),
                                                            const Text(
                                                              'Ver Pedido',  
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                color: Color(0xFF848484),
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 10.5
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
      bottomNavigationBar: const Footer(currentPageIndex: 3)
    );
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