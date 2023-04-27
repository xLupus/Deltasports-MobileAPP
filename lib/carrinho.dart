import 'dart:convert';

import 'package:deltasports_app/home.dart';
import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/pesquisa.dart';
import 'package:deltasports_app/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';
import 'package:http/http.dart' as http;

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

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}


class _CartScreenState extends State<CartScreen> {
  final List<Product> _items = [
    Product(
      name: 'Item 1',
      price: 10.0,
      quantity: 1,
      description: 'Descrição do Item 1',
      image: 'https://picsum.photos/200',
    ),
    Product(
      name: 'Item 2',
      price: 15.0,
      quantity: 1,
      description: 'Descrição do Item 2',
      image: 'https://picsum.photos/200',
    ),
    Product(
      name: 'Item 3',
      price: 20.0,
      quantity: 1,
      description: 'Descrição do Item 3',
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
    return Scaffold(
      appBar: AppBar(title: Text('Carrinho de Compras'),backgroundColor: GlobalColors.red),
      
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
                        builder: (context) => ProductDetailScreen(product: _items[index]),
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
          child: Icon(Icons.home),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutosPage(),
              ),
            );
          },
          child: Icon(Icons.category),
        ), 
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          },
          child: Icon(Icons.add_shopping_cart),
        ),        
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutosPage(),
              ),
            );
          },
          child: Icon(Icons.person),
        ),
          
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
      ], backgroundColor: GlobalColors.red
       
       ), //fimFooter

       
    );      
    

  }
}



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
  title: Text('Detalhes do Produto' ),backgroundColor: GlobalColors.red,
  ),body: Column(
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
          child: Icon(Icons.home),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutosPage(),
              ),
            );
          },
          child: Icon(Icons.category),
        ), 
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          },
          child: Icon(Icons.add_shopping_cart),
        ),        
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutosPage(),
              ),
            );
          },
          child: Icon(Icons.person),
        ),
          
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
      ], backgroundColor: GlobalColors.red
       
       ), //fimFooter
);
}

}

Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
