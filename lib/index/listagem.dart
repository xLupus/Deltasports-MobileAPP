import 'dart:convert';
import 'package:deltasports_app/categoria/categoria.dart';
import 'package:deltasports_app/auth/login_page.dart';
import 'package:deltasports_app/perfil/perfil.dart';
import 'package:deltasports_app/produto/produto.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../carrinho/carrinho.dart';
import '../categoria/categorias.dart';

import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;

import '../partials/footer.dart';
import '../produto/produtos.dart';
import '../utilis/obter_imagem.dart';

class ListagemPage extends StatefulWidget {
  const ListagemPage({Key? key, required foto}) : super(key: key);

  @override
  State<ListagemPage> createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  late Future<List> listaFotos;

  @override
  initState() {
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
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProdutoPage(dados: snapshot.data![index]), //fazer chamada listagem e detalhe
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: obterImagem(snapshot.data![index]['images']),
                            fit: BoxFit.cover)),

                    //estilizar
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'ID: ${snapshot.data![index]['id'].toString()}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            snapshot.data![index]['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Preço: ${intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data![index]['price']))}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
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
      bottomNavigationBar: const Footer() //fimFooter
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
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var url = Uri.parse('http://127.0.0.1:8000/api/products');
     final headers = {
    'Authorization': '${sharedPreference.getString("token")}',
    'Content-Type': 'application/json'
  };
    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {

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
