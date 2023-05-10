import 'package:deltasports_app/perfil.dart';
import 'package:deltasports_app/produtos.dart';
import 'package:flutter/material.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'carrinho.dart';
import 'index.dart';
import 'listagem.dart';

class ProdutoPage extends StatefulWidget {

  Map<String, dynamic> dados;

  ProdutoPage({Key? key, required this.dados}) : super(key: key);

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: GlobalColors.red,
        title: Text(widget.dados['name'],
        textAlign: TextAlign.center,),
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
              // TODO: decrementar a quantidade
            },
          ),

          Text('0'),

          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TODO: incrementar a quantidade
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

      Text(
        widget.dados['price'],
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
                onTap: () => {Navigator.of(context).pushReplacementNamed('/')},
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



      //Footter
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
      ], backgroundColor: GlobalColors.red),
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }


  dynamic obterImagem(dynamic url) {
    if (url.length > 0 && url[0] != null && url[0]['url'] != '') {
      return NetworkImage(url[0]['url']);
    }
    else {
      return const AssetImage('images/no_image.png');
    }
  }
}