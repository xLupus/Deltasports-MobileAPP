import 'dart:convert';

import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/pesquisa.dart';
import 'package:deltasports_app/produto.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';
import 'package:http/http.dart' as http;


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
                  builder: (context)=> 
                  ProdutoPage(foto: snapshot.data![index]),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Container(
            padding: const EdgeInsets.all(8),
            color: Color.fromARGB(192, 218, 217, 217),
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
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.settings), label: 'Configuração'),
        NavigationDestination(
            icon: Icon(Icons.add_shopping_cart), label: 'Carrinho'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
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


