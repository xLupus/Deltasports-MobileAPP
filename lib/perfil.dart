import 'dart:convert';

import 'package:deltasports_app/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'carrinho.dart';
import 'index.dart';
import 'listagem.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 100),
            Image.network('https://i.imgur.com/ell1sHu.png'),
            SizedBox(height: 50),
            Text(
              'teste',
              style: TextStyle(
                color: GlobalColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'email',
              style: TextStyle(
                color: GlobalColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 150),

            //Btn Editar Usuário
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: GestureDetector(
                onTap: () => {Navigator.of(context).pushReplacementNamed('/Editperfil')},
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
                      'Editar Usuário',
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

            SizedBox(height: 40),

            //Btn Pedidos
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
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Pedidos',
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

            SizedBox(height: 40),

            //Btn Endereços
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
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Endereços',
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
          ]),
        ),
      ),
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

  /*Future<List> perfil() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/auth/user');

    Map<String, String> headers = {
      'Authorization': '',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> nameJson = jsonDecode(response.body);

      String name = nameJson['name'];
      String email = emailJson['email'];
    } else {
      
      print('Erro ao obter o nome da API.');
    }
  }

  */
}
