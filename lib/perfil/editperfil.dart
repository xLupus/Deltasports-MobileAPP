import 'dart:convert';
import 'package:deltasports_app/perfil/perfil.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:http/http.dart' as http;
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../carrinho/carrinho.dart';
import '../index/index.dart';
import '../index/listagem.dart';

class EditperfilPage extends StatefulWidget {
  const EditperfilPage({Key? key}) : super(key: key);

  @override
  State<EditperfilPage> createState() => _EditperfilPageState();
}

class _EditperfilPageState extends State<EditperfilPage> {
  final _formkey = GlobalKey<FormState>();

  String? _nomeController;
  setName(String value) => _nomeController = value;

  String? _emailController;
  setLogin(String value) => _emailController = value;

  @override
  void initState() {
    super.initState();

    dadosDoUsuario().then((dados) {
      print(dados);

      setState(() {
        _nomeController = dados['name'];
        _emailController = dados['email'];
      });

      print(_nomeController);

    }).catchError((erro) {
      print(erro);

    });
  }

  final snackBar = SnackBar(
    content: Text(
      'e-mail ou senha são inválidos',
      textAlign: TextAlign.center,
    ),
    backgroundColor: GlobalColors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: Form(
        key: _formkey,
        child: Center(
          child: Column(children: [
            SizedBox(height: 50),
            Image.network('https://i.imgur.com/ell1sHu.png'),

            SizedBox(height: 90),

            //BemVindo
            const Align(
              alignment: Alignment(-0.75, 0.0),
              child: Text(
                'Editar Usuário',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            const SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: GlobalColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    onChanged: setName,
                    initialValue: '$_nomeController',
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Por favor, digite um nome';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            //Email 0xFF1C8394
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: GlobalColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    onChanged: setLogin,
                    initialValue: '$_emailController',
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Por favor, digite seu e-mail';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.toString())) {
                        return 'Por favor, digite um e-mail correto';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 100),

            //Btn salvar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (_formkey.currentState!.validate()) {
                    atualizarDados();
                    if (!currentFocus.hasFocus) {
                      currentFocus.unfocus();
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: GlobalColors.blue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Salvar',
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

  Future<dynamic> dadosDoUsuario() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    var client = http.Client();

    var url = Uri.parse('http://127.0.0.1:8000/api/user');

    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> r = json.decode(response.body);

      var data = r['data'];

      return data;
    }

    throw Exception('Erro ao carregar dados do Usuario');
  }

  Future<bool> atualizarDados() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    var client = http.Client();

    var url = Uri.parse('http://127.0.0.1:8000/api/user');

    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };

    var response = await client.patch(url,
        headers: headers,
        body: {'name': _nomeController, 'email': _emailController});

    if (response.statusCode == 200) {
      return true;

    } else {
      return false;
    }

    throw Exception('Erro ao carregar dados do Usuario');
  }
}
