import 'dart:convert';

import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/pesquisa.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'index.dart';
import 'package:http/http.dart' as http;


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
          child: Column(
            children: [
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Categorias',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Icon(
                  Icons.add,
                  color: GlobalColors.red,
                  size: 30.0,
                ),
              ],
            ),

            SizedBox(height: 10),

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
                      Navigator.of(context).pushReplacementNamed('/Teste')
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
                      Navigator.of(context).pushReplacementNamed('/Registrar')
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
                      Navigator.of(context).pushReplacementNamed('/Registrar')
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
                      Navigator.of(context).pushReplacementNamed('/Registrar')
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
            
         



          ]),
        ),
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

/* body: FutureBuilder<List>(
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
        itemCount: Snapshot.data!.length,
        itemBuilder: (context, index){
          return GestureDetector(
            ontTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=> 
                  DetalhePage(foto: snapshot.data![index]),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text(snapshot.data![index]['id'].toString());
              Text(snapshot.data![index]['title']);
            ],
          ),
         ), 
        );
      },
    );
    }else if(snapshot.hasError){
      return const Center(
        child: Text('Erro ao carregar dados),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  },
); */

