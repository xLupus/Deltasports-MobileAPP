import 'package:flutter/material.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart' as intl;

import '../carrinho/carrinho.dart';
import '../partials/footer.dart';

class ProdutoPage extends StatefulWidget {
  Map<String, dynamic> dados;

  ProdutoPage({Key? key, required this.dados}) : super(key: key);

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  int _qtdController = 1;

  
  @override
  Widget build(BuildContext context) {
    setQtd(int value) => setState(() {
          _qtdController = value;
        });

  final double _priceTotal = double.parse(widget.dados['price']) - double.parse(widget.dados['discount']);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.red,
        title: Text(
          widget.dados['name'],
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Image(
              image: obterImagem(widget.dados['images']),
              height: 400,
            ),
            SizedBox(height: 50),
            Text(
              widget.dados['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Unidades:'),
                SizedBox(width: 4),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (_qtdController > 1) {
                      setQtd(_qtdController - 1);
                    }
                  },
                ),
                Text('${_qtdController}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_qtdController < widget.dados['stock']) {
                      setQtd(_qtdController + 1);
                    }

                    print(_qtdController);
                  },
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              widget.dados['description'],
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text('${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(widget.dados['price']))}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text('${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(_priceTotal)}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: GestureDetector(
                onTap: () => {
                  AdicionarCart()
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GlobalColors.blue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Adicionar ao Carrinho',
                      style: TextStyle(
                        color: GlobalColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      //Fotter
      bottomNavigationBar: const Footer(),
    );
  }

  dynamic obterImagem(dynamic url) {
    if (url.length > 0 && url[0] != null && url[0]['url'] != '') {
      return NetworkImage(url[0]['url']);
    } else {
      return const AssetImage('images/no_image.png');
    }
  }

  Future<bool> AdicionarCart() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client = http.Client();
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };
    final url = Uri.parse('http://127.0.0.1:8000/api/user/cart');

    print([widget.dados['id'], widget.dados['stock']]);

    var resposta = await client.post(url,
        body: {
          'product': widget.dados['id'].toString(),
          'qtd': _qtdController.toString()
        },
        headers: headers);

    print(resposta);

    if (resposta.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CarrinhoPage()),
      );

      print(convert.jsonDecode(resposta.body));

      return true;
    } else {
      return false;
    }
  }
}
