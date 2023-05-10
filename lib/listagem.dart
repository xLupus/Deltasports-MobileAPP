import 'dart:convert';

import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/perfil.dart';
import 'package:deltasports_app/pesquisa.dart';
import 'package:deltasports_app/produto.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'carrinho.dart';
import 'index.dart';
import 'package:http/http.dart' as http;

import 'produtos.dart';


class ListagemPage extends StatefulWidget {
  const ListagemPage({Key? key, required foto}) : super(key: key);

  @override
  State<ListagemPage> createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {

  late Future<List> listaFotos;

  @override
  initState(){
    super.initState();
    listaFotos = pegarFotos();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: FutureBuilder<List>(
  future: listaFotos,
  builder: (context, snapshot) {
    if (snapshot.hasData){
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => 
                    ProdutoPage(dados: snapshot.data![index]),
                  fullscreenDialog: true,                  
                ),
                
              );
            },
            child: Container(
              decoration: BoxDecoration(image: DecorationImage(image: obterImagem(snapshot.data![index]['images']), fit: BoxFit.cover)),
            padding: const EdgeInsets.all(8),
            //estilizar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text(snapshot.data![index]['id'].toString()),
              Text(snapshot.data![index]['name']),
              Text(snapshot.data![index]['description']),
              Text(snapshot.data![index]['price'].toString()),
            ],
          ),
         ), 
        );
      },
    );
    }else if(snapshot.hasError){
      return const Center(
        child: Text('Erro ao carregar dados'),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  },
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
                builder: (context) => ListagemPage(foto: {}),
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
      ], backgroundColor: GlobalColors.red
       
       ), //fimFooter
    );
  }

  
  dynamic obterImagem(dynamic url) {
    if (url.length > 0 && url[0] != null && url[0]['url'] != '') {
      return NetworkImage(url[0]['url']);
    }
    else {
      return const AssetImage('images/no_image.png');
    }
  }


  Future<bool> verificarToker() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (sharedPreference.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> pegarFotos() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/products');
    var response = await http.get(url);
    if(response.statusCode == 200) {
      print(json.decode(response.body));

      Map<String, dynamic> r = json.decode(response.body);
      var products = r['data'];
      return products;
    }
    throw Exception('Erro ao carregar foto');
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}


