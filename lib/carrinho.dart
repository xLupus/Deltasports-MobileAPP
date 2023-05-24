import 'dart:convert';


import 'package:deltasports_app/home.dart';
import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/perfil.dart';
import 'package:deltasports_app/pesquisa.dart';
import 'package:deltasports_app/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';
import 'package:http/http.dart' as http;

import 'listagem.dart';

/*void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho de Compras',
      home: Carrinho(),
    );
  }
} */

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({Key? key}) : super(key: key);
  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  final List<Product> _items = [
    Product(
      name: 'oi',
      price: 10.0,
      quantity: 1,
      description: 'Descrição do Item 1',
      image: 'https://picsum.photos/200',
    ),
  ];

  double _totalPrice = 45.0;

  void _updateTotalPrice() {
    setState(() {
      _totalPrice = _items.fold(0.0, (total, item) => total + item.totalPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    produtos();
    return Scaffold(
      appBar: AppBar(
          title: Text('Carrinho de Compras'),
          backgroundColor: GlobalColors.red),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_items[index].quantity > 1) {
                              _items[index].quantity--;
                              _items[index].updateTotalPrice();
                              _updateTotalPrice();
                            } else {
                              _items.removeAt(index);
                              _updateTotalPrice();
                            }
                          });
                        },
                      ),
                      Text('${_items[index].quantity}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _items[index].quantity++;
                            _items[index].updateTotalPrice();
                            _updateTotalPrice();
                          });
                        },
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'R\$ ${_items[index].price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: _items[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(140.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontSize: 24.0)),
                Text(
                  'R\$ ${_totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmar Compra'),
                        content: Text('Deseja confirmar a compra?'),
                        actions: [
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Confirmar'),
                            onPressed: () {
                              checkout();

                              Navigator.of(context).pop();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Compra Realizada'),
                                    content: Text(
                                        'Sua compra foi realizada com sucesso!'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Confirmar Compra', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  backgroundColor: GlobalColors.blue,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
          //Final Botão de Confirmação de Compra
        ],
      ),

      //Footer
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
            )),
        TextButton(
          onPressed: () async {
            bool saiu = await sair();
            if (saiu) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => IndexPage(),
                ),
              );
            }
          },
          child: Text('Sair'),
        ),
      ], backgroundColor: GlobalColors.red), //fimFooter
    );
  }
}

// DETALHE DO ITEM NO CARRINHO

class Product {
  final String name;
  final double price;
  int quantity;
  final String description;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.image,
  });

  double get totalPrice => price * quantity;

  void updateTotalPrice() {
    totalPrice;
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Produto'),
        backgroundColor: GlobalColors.red,
      ),
      body: Column(
        children: [
          Image.network(
            product.image,
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.0),
          Text(
            product.name,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Text(
            product.description,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Reais: ${product.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),

      //Footer
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
            )),
        TextButton(
          onPressed: () async {
            bool saiu = await sair();
            if (saiu) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => IndexPage(),
                ),
              );
            }
          },
          child: Text('Sair'),
        ),
      ], backgroundColor: GlobalColors.red), //fimFooter
    );
  }
}

Future<bool> sair() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  return true;
}

Future<bool> checkout() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var client = http.Client();

  final headers = {
    'Authorization': '${sharedPreferences.getString("token")}',
  };

  final url = Uri.parse('http://127.0.0.1:8000/api/order');

  var resposta = await client.post(
    url, 
    body: {},
    headers: headers
    );


  if (resposta.statusCode == 200) {
    /* Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MeusPedidos()),
    ); */
    print('Pedido realizado com sucesso');
    return true;
  } else {
    return false;
  }
}

Future<List> produtos() async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();

  var url = Uri.parse('http://127.0.0.1:8000/api/user/cart');

  final headers = {
    'Authorization': '${sharedPreference.getString("token")}',
    'Content-Type': 'application/json'
  };

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    print([response.statusCode, response.body]);

    Map<String, dynamic> r = json.decode(response.body);
    var _items = r['data'];
    var resultado = '';
    return _items;
  }
  throw Exception('Erro ao carregar foto');
}
