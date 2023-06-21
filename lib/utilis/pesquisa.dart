import 'package:deltasports_app/produto/produto.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';

import 'obter_imagem.dart';

class PesquisaPage extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Pesquise por nome, marca ou categoria ...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        padding: const EdgeInsets.only(left: 5),
        onPressed: () { query = ''; },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () { close(context, ''); },
      icon: const Icon(Icons.arrow_back),
      padding: const EdgeInsets.only(right:20)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<Map<dynamic, dynamic>>(
      future: resultado(query),
      builder: (context, snapshot) {          
      var products = snapshot.data!['data'];

      if (snapshot.hasData) {
        return ListView(
          children: [
            Image.network(products!['images']),
            obterImagem(products!['images']),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        products!['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                        Text(intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(products!['price'] - products!['discount']))
                    ],
                  ),
                  Text(
                    products!['category'],
                    style: const TextStyle(fontStyle: FontStyle.italic)
                  )
                ]
              )
            )
          ]
        );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Nenhum produto encontrado ...'));
        }
        return const Center( child: CircularProgressIndicator());
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder<List>(
        future: sugestoes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
             return const Center(  
                    child: CircularProgressIndicator(
                      color: Color(0xFFBABABA),
                    ),
                  );
          } else if (snapshot.hasError) {
            
              return const Text(
               'Nenhum produto encontrado ...',
          style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 20
            )
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                  return ListTile(
                    leading: obterImagemPesquisa(snapshot.data![index]['images']),
                    title: Text(snapshot.data![index]['name'].toString()),
                    subtitle: Text(snapshot.data![index]['category']['name'].toString()), 
                    trailing: Text(intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data![index]['price']))),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                            ProdutoPage(data: snapshot.data![index])
                        )
                      );
                      query = snapshot.data![index]['id'];
                      showResults(context);
                    },
                  );
            }
          );
        }
      }
    );
  }

  Future<List> sugestoes() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var url = Uri.parse('http://127.0.0.1:8000/api/products/search/$query');
  
    final headers = {
    'Authorization': '${sharedPreference.getString("token")}',
    'Content-Type': 'application/json'
  };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      //print(json.decode(response.body));

      Map<String, dynamic> r = json.decode(response.body);
      var products = r['data'];
      return products;
    } else {
     // print('erro');
    }

    throw Exception('Erro ao solicitar o produto presquisa');
  }

  Future<Map<dynamic, dynamic>> resultado(String id) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var url = Uri.parse('http://127.0.0.1:8000/api/product/$id');

    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> pesquisa = jsonDecode(response.body);

      return pesquisa;
    }
    throw Exception('Erro ao solicitar o produto presquisa');
  }
}
