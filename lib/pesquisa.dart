import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PesquisaPage extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'ex: nome, marca';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
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
                //Image.network(products!['images']),

               obterImagem(products!['images']),
   
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              products!['name'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(products!['price'] -
                                products!['discount']),
                          ],
                        ),
                        Text(
                          products!['category'],
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(products!['description']),
                      ]),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Nenhum produto encontrado'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Container();
    }
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
                    trailing: Text(snapshot.data![index]['price'].toString()),
                    onTap: () {
                      query = snapshot.data![index]['id'].toString();
                      showResults(context);
                    },
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao pesquisar produtos!'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Future<List> sugestoes() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var url = Uri.parse('http://127.0.0.1:8000/api/products/search/$query');

    final headers = {
    'Authorization': '${sharedPreference.getString("token")}',
    'Content-Type': 'application/json'
  };

    var response = await http.get(url, headers: headers);
      //print([query,response.statusCode]);
    if (response.statusCode == 200) {
      //print(json.decode(response.body));

      Map<String, dynamic> r = json.decode(response.body);
      var products = r['data'];
      return products;
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
     // print(json.decode(response.body));

      Map<String, dynamic> r = json.decode(response.body);
      return r;
    }
    throw Exception('Erro ao solicitar o produto presquisa');
  }

  dynamic obterImagem(dynamic url) {
    print([url,url.length]);
    /*if (url.length > 0 && url[0] != null && url[0]['url'] != '') {
      return NetworkImage(url[0]['url']);
    } else {
      return const AssetImage('images/no_image.png');
    }*/
    return const AssetImage('images/no_image.png');
  }
}
