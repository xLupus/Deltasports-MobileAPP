import 'dart:convert';

import 'package:deltasports_app/pedido/pedidos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import '../partials/footer.dart';
import '../partials/header.dart';
import '../utilis/obter_imagem.dart';
import '../utilis/snack_bar.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);
  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  late Future<dynamic> _data;
  late Future<dynamic> _address;

  bool isLoading = false;
  double totalPrice = 0;
  double frete      = 0;
  int val           = 700;

  @override
  initState() {  
    super.initState();
    _data     = mostrar();
    _address  = endereco(80);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.85,
            child: Column(
              children: [
                const SizedBox(
                 height: 135,
                 child: HeaderTwo()
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
                                    'Checkout',
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
                    future: Future.wait([_data, _address]),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                      /* while(snapshot.data[0]['total_price'] > val) {
                        val += 700;
                        frete += 7.37;
                      } */

                      return Column(
                        children: [
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
                                                      '${snapshot.data[1]['street']}, ${snapshot.data[1]['number']}',                            
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
                                                      '${snapshot.data[1]['zip_code']}',                            
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
                                                      intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(99.0),                            
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
                          const SizedBox(height: 15),
                          SizedBox(
                            height: screenHeight - 650,
                            child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data[0]['cart'].length,
                                      itemBuilder: (context, index) {
                                        final double priceTotal = double.parse(snapshot.data[0]['cart'][index]['price']) - double.parse(snapshot.data[0]['cart'][index]['discount']);

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
                                                      height: 110,
                                                      width: 110,
                                                      decoration: 
                                                      BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                                                          color: const Color(0xFFE5E5E5),
                                                          image: DecorationImage(
                                                          image: obterImagem(snapshot.data[0]['cart'][index]['images']),
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
                                                                  '${snapshot.data[0]['cart'][index]['name']}',
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
                                                                '${snapshot.data[0]['cart'][index]['description']}',   
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
                                                                    intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data[0]['cart'][index]['price'])),                
                                                                    overflow: TextOverflow.ellipsis,
                                                                     style: priceTotal != double.parse(snapshot.data[0]['cart'][index]['price']) ? 
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
                                                           priceTotal < double.parse(snapshot.data[0]['cart'][index]['price']) ? 
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
                                                              snapshot.data[0]['cart'][index]['qtd'] < 10 ? '0${snapshot.data[0]['cart'][index]['qtd']}' : '${snapshot.data[0]['cart'][index]['qtd']}',                 
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
                          ),
                          ),
                          const SizedBox(height: 20),
                      Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                      return const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.center,
                                        child: Text(
                                            'Subtotal:',
                                            style: TextStyle(
                                              color:Color(0xFF1E1E1E),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14
                                            )
                                          )
                                        );
                                      }
                                    )
                                  )
                                ),
                                Expanded(
                                  child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                    return Row(
                                            children: [
                                             Expanded(
                                              child:  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                                  return FittedBox( 
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                        intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(1.00),
                                                        style: const TextStyle(
                                                          color: Color(0xFF1E1E1E),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14
                                                        )
                                                      )
                                                    );
                                                  }
                                                ),
                                             )
                                            ],
                                          );
                                    }
                                  ),
                                  
                                ),
                              ]
                ),
                 Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                      return const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.center,
                                        child: Text(
                                            'Total:',
                                            style: TextStyle(
                                              color:Color(0xFF1E1E1E),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22
                                            )
                                          )
                                        );
                                      }
                                    )
                                  )
                                ),
                                Expanded(
                                  child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                    return Row(
                                            children: [
                                             Expanded(
                                              child:  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                                  return FittedBox( 
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                        intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(20.0),
                                                        style: const TextStyle(
                                                          color: Color(0xFF1E1E1E),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 22
                                                        )
                                                      )
                                                    );
                                                  }
                                                ),
                                             )
                                            ],
                                          );
                                    }
                                  ),
                                  
                                ),
                              ]
                ),
                           SizedBox(
                    height: screenHeight - 850,
                        child: Center(
                          child: ElevatedButton(               
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isLoading ? const Color(0xFF919191) : GlobalColors.blue,
                              foregroundColor: GlobalColors.white,
                              padding: const EdgeInsets.all(10.0),
                              fixedSize: Size(screenWidth * 0.85, 55.0),
                              textStyle: const TextStyle(
                                fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                              ),
                              elevation: 20.0,
                              shadowColor: const Color(0xD2000000),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                            ),
                            onPressed: () { checkout(); },
                            child: isLoading ? const SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: Color(0xFFBABABA)
                              ),
                            ) : const Text('Comprar'),
                          ),
                        )
                      )
                        ],
                      );
                    }
                  }
                )
              ]
            )
          )
        )
      ),
      bottomNavigationBar: const Footer()
    );
  }

  Future<void> checkout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var client = http.Client();

    setState(() {
      isLoading = true;
    });
    
    final headers = {
      'Authorization': '${sharedPreferences.getString("token")}',
    };

    final url = Uri.parse('http://127.0.0.1:8000/api/order');
    var response = await client.post(url, body: {}, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      WidgetsBinding.instance.addPostFrameCallback((_) { 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PedidosPage(dados: {})),
        );
        snackBar(context, data['message']); 
      });
    } else if(response.statusCode == 404) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['message'];
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> endereco(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var client = http.Client();
    final headers = {
      'Authorization': '${sharedPreferences.getString("token")}',
    };

    final url = Uri.parse('http://127.0.0.1:8000/api/user/address/$id');

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> address = json.decode(response.body);
      return address['data'];
    }
  }

  Future<Map<String, dynamic>> mostrar() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var url = Uri.parse('http://127.0.0.1:8000/api/user/cart');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> cart = json.decode(response.body);
      
      return cart['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = json.decode(response.body);
      return error['message'];
    }

    throw Exception('Erro ao carregar itens');
  }
}

















/*  */