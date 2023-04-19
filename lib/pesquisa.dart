import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PesquisaPage extends SearchDelegate<String>{

  @override
  String get searchFieldLabel => 'ex: nome, marca';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: Icon(Icons.clear),),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: () {
      close(context, '');
    }, icon: Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder<Map<String, dynamic>>(
      future: resultado(query),
      builder: (context, snapshot) {        print(snapshot.hasData);
        if(snapshot.hasData){
          return ListView(
            children: [
              Image.network(snapshot.data!['images'][0]),
              Padding(padding: EdgeInsets.all(12), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(snapshot.data!['name'], style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(snapshot.data!['price'] - snapshot.data!['discount']),
                    ],
                  ),
                  Text(snapshot.data!['category'], style: TextStyle(fontStyle: FontStyle.italic),),
                  Text(snapshot.data!['description']),
                ]),),
            ],
          );
        }else if (snapshot.hasError){
          return Center(child: Text('Nenhum produto encontrado'),);
        }
        return Center(child: CircularProgressIndicator(),
        );
      });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if(query.isEmpty){
      return Container();
    }
    return FutureBuilder<List>(
      future: sugestoes(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(snapshot.data![index]['images'][0]),
                title: Text(snapshot.data![index]['name']),
                subtitle: Text(snapshot.data![index]['category']),
                trailing: Text(snapshot.data![index]['price']),
                onTap: (){
                  query = snapshot.data![index]['id'].toString();
                  showResults(context);
                },
              );
            });
        }else if(snapshot.hasError){
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
    var url = Uri.parse('http://127.0.0.1:8000/api/product/search/$query');

    Map<String, String> headers ={
      'Authorization': 'Token ...',
    };

    var response = await http.get(url/* , headers: headers */);

    if(response.statusCode == 200){
      return convert.jsonDecode(response.body).map((produto) => produto).toList();
    }

    throw Exception('Erro ao solicitar o produto presquisa');
  }


  Future<Map<String, dynamic>> resultado(String id) async{
    var url = Uri.parse('http://127.0.0.1:8000/api/product/$id');
    
    Map<String, String> headers ={
      'Authorization': 'Token ...',
    };

    var response = await http.get(url/* , headers: headers */);

    if(response.statusCode == 200){
      return convert.jsonDecode(response.body);
    }
    throw Exception('Erro ao solicitar o produto presquisa');
  }
}