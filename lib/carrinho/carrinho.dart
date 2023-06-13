import 'dart:convert';

import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import '../partials/footer.dart';
import '../partials/header.dart';
import '../utilis/obter_imagem.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({Key? key}) : super(key: key);
  @override
  CarrinhoPageState createState() => CarrinhoPageState();
}

class CarrinhoPageState extends State<CarrinhoPage> {
  late Future<dynamic>_data;
  // dynamic items;

  double frete  = 0;
  int val       = 700;

  @override
  initState() { 
    super.initState();
    _data = mostrar(); 
  }

  List<Product> items = [
    Product(
      name: 'oi',
      price: 1,
      quantity: 0,
      description: 'Descrição do Item 1',
      image: 'https://picsum.photos/200',
    ),
  ];

  double _totalPrice = 0;

  void _updateTotalPrice() {
    setState(() {
      _totalPrice = items.fold(0.0, (total, item) => total + item.totalPrice);
    });
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
                                    'Meu Carrinho',
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
                      return Column(
                        children: [
                           SizedBox(    
  
                            height: screenHeight - 496,
                            child:  ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data['cart'].length,
                        itemBuilder: (context, index) {
                          final double priceTotal = double.parse(snapshot.data['cart'][index]['price']) - double.parse(snapshot.data['cart'][index]['discount']);
                           
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
                                                          image: obterImagem(snapshot.data['cart'][index]['images']),
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
                                                                  '${snapshot.data['cart'][index]['name']}',
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
                                                                '${snapshot.data['cart'][index]['description']}',   
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
                                                                    intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data['cart'][index]['price'])),                
                                                                    overflow: TextOverflow.ellipsis,
                                                                     style: priceTotal != double.parse(snapshot.data['cart'][index]['price']) ? 
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
                                                priceTotal < double.parse(snapshot.data['cart'][index]['price']) ? 
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
                                  Column(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            height: 35,
                                          width: 83,    
                                            child: LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                               return GestureDetector(
                                                  onTap: () { 
                                                    items.removeAt(index); 
                                                    _updateTotalPrice();
                                                  },
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: GlobalColors.red,
                                                      size: 22
                                                    )
                                                  )
                                                );
                                              }
                                            ) 
                                          )
                                        )
                                      ),
                                      Expanded(
                                        child:  Align(
                                          alignment: Alignment.bottomRight,
                                          child: SizedBox(
                                            height: 35,
                                            width: 83,    
                                            child: LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                return  Container(          
                                                  padding: const EdgeInsets.all(6),                                  
                                                  decoration: const BoxDecoration(
                                                    color: Color(0x991C8394),
                                                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                                                  ),
                                                  constraints: const BoxConstraints(),
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () { 
                                                             if (items[index].quantity > 1) {
                                      items[index].quantity--;
                                      items[index].updateTotalPrice();
                                      _updateTotalPrice();
                                    } else {
                                      items.removeAt(index);
                                      print({items, index});
                                      _updateTotalPrice();
                                    }
                                                          },
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: GlobalColors.white,
                                                              size: 14
                                                            )
                                                          )
                                                        )
                                                      ),
                                                      Text(
                                                        '$_totalPrice',                 
                                                        textAlign: TextAlign.center,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: GlobalColors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16
                                                        )
                                                      ),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () { 
                                                             setState(() {
                                                              items[index].quantity++;
                                                              items[index].updateTotalPrice();
                                                              _updateTotalPrice();
                                                            });
                                                          },
                                                          child: Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Icon(
                                                              Icons.add,
                                                              color: GlobalColors.white,
                                                              size: 14
                                                            )
                                                          )
                                                        )
                                                      )
                                                    ]
                                                  )
                                                );  
                                              }
                                            )
                                          )
                                        )
                                      )
                                    ]
                                  )
                                ]
                              )
                            )
                          );
                        }
                      ),
                          ),
                      const SizedBox(height: 77),
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
                                                        intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(100.0),
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
                                                        intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(99.0),
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
                              backgroundColor: GlobalColors.blue,
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
                            onPressed: () { Navigator.of(context).pushNamed('/Checkout'); },
                            child: const Text('Ir para Checkout')
                          ),
                        )
                      )

                        ],
                      );
                    }
                  }
                ),
              ]
            )
          )
        )
      ),
      bottomNavigationBar: const Footer()
    );
  }
}

// DETALHE DO ITEM NO CARRINHO

class Product {
  final String name;
  final double price;
  late int quantity;
  final String description;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json){ 
    return Product(
      name: json['name'], 
      price: json['price'],
      image: json['image'],
      description:  json['description'],
      quantity: json['quanatity'], 
    );
  }

  double get totalPrice => price * quantity;

  void updateTotalPrice() {
    totalPrice;
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
    throw Exception('Não há itens no carrinho ...');
  }

  throw Exception('Erro ao carregar Carrinho');
}
