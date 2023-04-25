import 'package:flutter/material.dart';

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

class Carrinho extends StatefulWidget {
  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  final List<Product> _items = [
    Product(name: 'Item 1', price: 10.0, quantity: 1),
    Product(name: 'Item 2', price: 15.0, quantity: 1),
    Product(name: 'Item 3', price: 20.0, quantity: 1),
  ];
  double _totalPrice = 45.0;

  void _updateTotalPrice() {
    setState(() {
      _totalPrice = _items.fold(0.0, (total, item) => total + item.totalPrice);
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
      _updateTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrinho de Compras')),
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
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteItem(index);
                        },
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$ ${_items[index].price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Descrição do produto',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
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
    );
  }
}

class Product {
  final String name;
  final double price;
  int quantity;

  Product({required this.name, required this.price, required this.quantity});

  double get totalPrice => price * quantity;

  void updateTotalPrice() {
    totalPrice;
  }
}
