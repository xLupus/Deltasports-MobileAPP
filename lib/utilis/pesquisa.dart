import 'package:deltasports_app/produto/produto.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';

class PesquisaPage extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Pesquise por nome, marca ou categoria ...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () { query = ''; },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () { close(context, ''); },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
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
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    //erro aqui
                    //leading: Image.network(snapshot.data![index]['images'][0]['url'].toString()),
                    leading: obterImagem(snapshot.data![index]['images']),
                    title: Text(snapshot.data![index]['name'].toString()),
                    subtitle: Text(snapshot.data![index]['category']['name'].toString()), 
                    trailing: Text('R\$ ${snapshot.data![index]['price'].toString()}'),
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProdutoPage(data: snapshot.data![index])));
                      query = snapshot.data![index]['id'];
                      showResults(context);
                    },
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Nenhum produto encontrado ...'),
            );
          }
          return const Center( child: CircularProgressIndicator(),);
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
       print(products);
      return products;
    } else {
      print('erro');
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

  dynamic obterImagem(dynamic url) {
    if (url.length > 0 && url[0] != null && url[0]['url'] != '') {
      return Image(image: NetworkImage(url[0]['url']));
    } else {
      return const Image(image: AssetImage('images/no_image.png'));
    }
  }
}
