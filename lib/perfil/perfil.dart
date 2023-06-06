import 'dart:convert';
import 'dart:async';

import 'package:deltasports_app/auth/login_page.dart';
import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/index/listagem.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../index/index.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late Future<dynamic> _data;

  bool isLoading = false;
  dynamic name = '';
  dynamic email = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth  = MediaQuery.of(context).size.width;
      setState(() {
        _data = perfil();
      });

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.8,
            child: FutureBuilder(
              future: _data, 
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(  
                    child: CircularProgressIndicator(
                      color: Color(0xFFBABABA),
                    ),
                  );
                } else if(snapshot.hasError) {
                  return Center(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            snapshot.error.toString().substring(11),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            )
                          )
                        );
                      }
                    )
                  );
                } else {
                  return Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 50),
                          child: GestureDetector(
                            onTap: () { 
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const ProdutosPage())
                              );
                            },
                            child: Image.network('https://i.imgur.com/ell1sHu.png')
                          )
                        )
                    ),
                    SizedBox(
                      height: 55,
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                            alignment: Alignment.centerLeft,
                              child: LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints) {
                                  return FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      snapshot.data['name'],
                                      style: TextStyle(
                                        color: GlobalColors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22
                                      )
                                    )
                                  );
                                }
                              )  
                            )
                          ),
                          Expanded(
                            child: Align(
                            alignment: Alignment.centerLeft,
                              child: LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints) {
                                  return FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      snapshot.data['email'],
                                      style: const TextStyle(
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 22
                                      )
                                    )
                                  );
                                }
                              )  
                            )
                          ),
                        ],
                      )
                    ),
                    
                    const SizedBox(height: 30),
                
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      height: 202,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x6D000000),
                            offset: Offset(0, 4),
                            blurRadius: 4
                          )
                        ],
                        border: Border.all(
                          width: 3,
                          color: GlobalColors.red
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(22.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.person_outline,
                                          color: GlobalColors.blue,
                                          size: 28
                                        )
                                      );
                                    }
                                  )
                                ),
                                Expanded(
                                  flex: 4,
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Editar Usuário',
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                          )
                                        )
                                      );
                                    }
                                  )
                                ),
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () => { Navigator.of(context).pushNamed('/Editperfil') },
                                          child: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Color(0xFF000000),
                                            size: 28
                                          )
                                        )
                                      );
                                    }
                                  )
                                )
                              ]
                            ),

                            const Spacer(),
                        
                            Row(
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.paid_outlined,
                                          color: GlobalColors.blue,
                                          size: 28
                                        )
                                      );
                                    }
                                  )
                                ),
                                Expanded(
                                  flex: 4,
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Pedidos',
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                          )
                                        )
                                      );
                                    }
                                  )
                                ),
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () => { Navigator.of(context).pushNamed('/MeusPedidos') },
                                          child: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Color(0xFF000000),
                                            size: 28
                                          )
                                        )
                                      );
                                    }
                                  )
                                )
                              ]
                            ),

                            const Spacer(),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: SvgPicture.asset(
                                          'assets/svg/deployed_code.svg',
                                            width: 28,
                                            height: 28,
                                            colorFilter: ColorFilter.mode(GlobalColors.blue, BlendMode.srcIn)
                                          ),
                                        );
                                      }
                                    )
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: LayoutBuilder(
                                      builder: (BuildContext context, BoxConstraints constraints) {
                                        return const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Endereços',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                            )
                                          )
                                        );
                                      }
                                    )
                                  ),
                                  Expanded(
                                    child: LayoutBuilder(
                                      builder: (BuildContext context, BoxConstraints constraints) {
                                        return FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: () => { Navigator.of(context).pushNamed('/Enderecos') },
                                            child: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Color(0xFF000000),
                                              size: 28
                                            )
                                          )
                                        );
                                      }
                                    )
                                  )
                                ]
                              )  
                            ]
                          )
                        )
                      ),

                      Expanded(
                        child: Center(
                          child: ElevatedButton(               
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalColors.red,
                              foregroundColor: GlobalColors.white,
                              padding: const EdgeInsets.all(10.0),
                              fixedSize: Size(screenWidth * 0.8, 55.0),
                              textStyle: const TextStyle(
                                fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                              ),
                              elevation: 20.0,
                              shadowColor: const Color(0xD2000000),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                            ),
                            onPressed: () { logout(); },
                            child: const Text('Sair')
                          ),
                        )
                      )
                    ]
                  );
                }
              }
            )
          )
        )
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
            ))
      ], backgroundColor: GlobalColors.red),
    );
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var client = http.Client();
    var url = Uri.parse('http://127.0.0.1:8000/api/auth/logout');
    final headers = {'Authorization': '${sharedPreferences.getString("token")}'};
    await client.get(url,  headers: headers);
    await sharedPreferences.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
      );
    });
  }

  Future<void> perfil() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client = http.Client();
    var url = Uri.parse('http://127.0.0.1:8000/api/user');

    final headers = { 'Authorization': '${sharedPreference.getString("token")}' };

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      return data['data'];
    }

    throw Exception('Erro ao carregar os dados do Usuário');
  }
}
