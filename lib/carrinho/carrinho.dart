import 'dart:convert';

import 'package:deltasports_app/index/home.dart';
import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/auth/login_page.dart';
import 'package:deltasports_app/pedido/pedidos.dart';
import 'package:deltasports_app/perfil/perfil.dart';
import 'package:deltasports_app/produto/pesquisa.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../index/index.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import '../index/listagem.dart';
import '../partials/footer.dart';
import '../produto/produto.dart';

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
  late Future<List> exibirCarrinho;
  // dynamic items;

  double frete = 0;
  int val = 700;

  @override
  initState() {
    super.initState();
    exibirCarrinho = produtos();
  }

  final List<Product> items = [
    Product(
      name: 'oi',
      price: 10.0,
      quantity: 1,
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
    return Scaffold(
        appBar: AppBar(
            title: const Text('Carrinho de Compras'),
            backgroundColor: GlobalColors.red),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List>(
                future: exibirCarrinho,
                builder: (context, snapshot) {
                  
                  if (snapshot.hasData) {
                    
                    print(snapshot.data);
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data![index]);
                        return ListTile(
                          title: Text(snapshot.data![index]['name']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (items[index].quantity > 1) {
                                      items[index].quantity--;
                                      items[index].updateTotalPrice();
                                      _updateTotalPrice();
                                    } else {
                                      items.removeAt(index);
                                      print({items, index});
                                      _updateTotalPrice();
                                    }
                                  });
                                },
                              ),
                              Text('${_totalPrice}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    items[index].quantity++;
                                    items[index].updateTotalPrice();
                                    _updateTotalPrice();
                                  });
                                },
                              ),
                            ],
                          ),
                          subtitle: Text(
                            '${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data![index]['price']))}',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          /*onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProdutoPage(dados: {},),
                            ),
                          );
                        },*/
                        );
                      },
                      
                    );
                    
                  } else if (snapshot.hasError) {
                   
                    //print(snapshot.hasError);
                    //print(snapshot.error);

                    return const Center(
                      child: Text('Carrinho Vazio'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Total:', style: TextStyle(fontSize: 24.0)),
                  Text(
                    '${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(_totalPrice + frete)}',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Frete: ${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(frete)}',
                    style: const TextStyle(fontSize: 20.0),
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
                          title: const Text('Confirmar Compra'),
                          content: const Text('Deseja confirmar a compra?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Confirmar'),
                              onPressed: () {
                                checkout();

                                Navigator.of(context).pop();

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Compra Realizada'),
                                      content: const Text(
                                          'Sua compra foi realizada com sucesso!'),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const PedidosPage(
                                                  dados: {},
                                                ),
                                              ),
                                            );
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
                  child: Text('Confirmar Compra',
                      style:
                          TextStyle(fontSize: 20, color: GlobalColors.white)),
                  style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                      backgroundColor: GlobalColors.blue,
                      foregroundColor: GlobalColors.white),
                ),
                const SizedBox(height: 30),
              ],
            ),
            //Final Botão de Confirmação de Compra
          ],
        ),

        //Footer
        bottomNavigationBar: const Footer());
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
          title: const Text('Detalhes do Produto'),
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
            const SizedBox(height: 16.0),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              product.description,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Reais: ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        //Footer
        bottomNavigationBar: const Footer() //fimFooter
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

  var resposta = await client.post(url, body: {}, headers: headers);

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
    Map<String, dynamic> r = json.decode(response.body);
    var items = r['data']['cart'];

    //print(items);

    return items;
  }

  throw Exception('Erro ao carregar Carrinho');
}
