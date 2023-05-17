import 'dart:convert';
import 'dart:html';

import 'package:deltasports_app/home.dart';
import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/perfil.dart';
import 'package:deltasports_app/pesquisa.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';
import 'package:http/http.dart' as http;

import 'listagem.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({Key? key}) : super(key: key);

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  late Future<List> listaFotos;

  /* @override
  initState(){
    super.initState();
    listaFotos = pegarFotos();
  } */

  @override
  void initState() {
    super.initState();
    listaFotos = pegarFotos();
    verificarToker().then((value) {
      if (!value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 20),

            //Logo E Search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.network('https://i.imgur.com/ell1sHu.png'),
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: PesquisaPage());
                  },
                  icon: Icon(Icons.search_rounded),
                ),
              ],
            ),

            SizedBox(height: 50),
            //Titulo "Produtos e ADD"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Produtos / Categorias',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            //Categorias
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Deslizar na horizontal
              children: <Widget>[
                //Tênis
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 05.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed('/Listagem')
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        color: GlobalColors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Tênis',
                          style: TextStyle(
                            color: GlobalColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ), //Fim_Tenis

                //Roupas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 05.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed('/Listagem')
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        color: GlobalColors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Roupas',
                          style: TextStyle(
                            color: GlobalColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ), //Fim Roupas

                //Acessórios
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 05.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed('/Listagem')
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        color: GlobalColors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Acessórios',
                          style: TextStyle(
                            color: GlobalColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ), //Fim Acessórios

                //Bolas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 05.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed('/Listagem')
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        color: GlobalColors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Bolas',
                          style: TextStyle(
                            color: GlobalColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ), //Fim Bolas

                //Adicionar restante da categoria
              ],
            ),
            SizedBox(height: 10),

            Container()
          ]),
        ),
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
    var client =  http.Client();
    var url = Uri.parse('http://127.0.0.1:8000/api/products');
    final headers = {
    'Authorization': '${sharedPreference.getString("token")}',
    'Content-Type': 'application/json'
  };
    var response = await client.get(url, headers: headers);

    
    print([response.statusCode, sharedPreference.getString("token")]);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body).map((foto) => foto).toList();
    }
    throw Exception('Erro ao carregar foto');
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
