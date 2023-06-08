import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:deltasports_app/categoria/categorias.dart';
import 'package:deltasports_app/index/home.dart';
import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/auth/login_page.dart';
import 'package:deltasports_app/perfil/perfil.dart';
import 'package:deltasports_app/produto/pesquisa.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../categoria/categoria.dart';
import '../index/index.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import '../index/listagem.dart';
import '../partials/footer.dart';
import '../partials/header.dart';
import '../utilis/obter_imagem.dart';
import 'produto.dart';



class ProdutosPage extends StatefulWidget {
  const ProdutosPage({Key? key}) : super(key: key);

  @override
  State<ProdutosPage> createState() => ProdutosPageState();
}

class ProdutosPageState extends State<ProdutosPage> {
  //late Future<List> listaFotos;
  late Future<List<dynamic>> _data;
  late Future<dynamic> _category;
  late Future<dynamic> _profile;

  late int id;
  var random = Random();
  
  @override
  Widget build(BuildContext context) {
    double screenWidth    = MediaQuery.of(context).size.width;
    double screenHeight   = MediaQuery.of(context).size.height;

    setState(() { 
      _data     = mostrar(); 
      _category = mostrarCategorias();
      _profile  = perfil();
    });

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: screenWidth * 0.8,
                child: FutureBuilder(
                    future: Future.wait([_data, _category, _profile]),
                    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: screenHeight - 315,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFBABABA)
                                  )
                                )
                              )
                            );
                          }
                        );
                      } else if(snapshot.hasError) {
                        return LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: screenHeight - 315,
                                child: Center(
                                  child: Text(
                                    snapshot.error.toString().substring(11),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    )
                                  )
                                )
                              )
                            );
                          }
                        );
                      } else {
                        int val = random.nextInt(snapshot.data![0].length - 1 + 1);

                        return Column(
                          children: [
                            const SizedBox(
                              height: 135,
                              child: HeaderTwo()
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child:  LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Bem-vindo(a) ao ',
                                                style: TextStyle(
                                                  color: Color(0xFF3D3D3D),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24
                                                )
                                              ),
                                              TextSpan(
                                                text: 'Delta !',
                                                style: TextStyle(
                                                  color: GlobalColors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24
                                                )
                                              )
                                            ]
                                          )
                                        )
                                      );
                                    }
                                  )
                                )   
                              ]
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            snapshot.data![2]['name'],
                                            style: const TextStyle(
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24
                                          )
                                        )
                                      );
                                    }
                                  )
                                )
                              ]
                            ),
                            const SizedBox(height: 30),
                           Row(
                            children: [
                              Expanded(
                                child:  Container(
                                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                                  height: 130,                               
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
                                      color: Colors.transparent
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(22.0))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 22.0),
                                      child: Row(
                                        children: [                  
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                            return Container(              
                                              height: 106,
                                              width: 106,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                                                  color: const Color(0xFFE5E5E5),
                                                  image: DecorationImage(
                                                    image: obterImagem(snapshot.data![0][val]['images']),
                                                    fit: BoxFit.fitWidth                                                                            
                                                  )
                                                )
                                              ); 
                                            }
                                          ),
                                          const Spacer(),
                                          Flexible(
                                            flex: 7,
                                            child: LayoutBuilder(
                                            builder: (BuildContext context, BoxConstraints constraints) {
                                              return Column(
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: LayoutBuilder(
                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                      return Container(
                                                        constraints: const BoxConstraints(),
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                            '${snapshot.data![0][val]['name']}',
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              color: Color(0xFF000000),
                                                              height: 1.15,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16
                                                            )
                                                          )
                                                        );
                                                      }
                                                    )
                                                  ),
                                                  const Spacer(),
                                                  Expanded(
                                                    flex: 4,
                                                    child:  LayoutBuilder(
                                                      builder: (BuildContext context, BoxConstraints constraints) {
                                                        return Container(
                                                          constraints: const BoxConstraints(),
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            '${snapshot.data![0][val]['description']}',   
                                                            maxLines: 2,                         
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              color: Color(0xFF848484),
                                                              fontWeight: FontWeight.w400,
                                                              height: 1.15,
                                                              fontSize: 12
                                                            )
                                                          ) 
                                                        );
                                                      }
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                    Expanded(
                                                      flex: 3,
                                                      child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return Container(
                                                            constraints: const BoxConstraints(),
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(snapshot.data![0][val]['price'])),                
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                  color: Color(0xFF000000),
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 16
                                                                )
                                                              )
                                                            );
                                                          }
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }
                                              )
                                            ),  
                                            const Spacer(),
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 40,
                                                width: 40,    
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ProdutoPage(dados: snapshot.data![0][val])),
                                                  );
                                                },
                                                child: LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return Container(                                            
                                                    decoration: BoxDecoration(
                                                      color: GlobalColors.red,
                                                      borderRadius: const BorderRadius.all(Radius.circular(15.0))
                                                    ),
                                                    constraints: const BoxConstraints(),
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.arrow_forward_ios_outlined,
                                                      color: GlobalColors.white,
                                                      size: 18
                                                    )
                                                  );
                                                }
                                              )
                                            )
                                          )
                                        )
                                      ]
                                    )
                                  )
                                )
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Categorias',
                                          style: TextStyle(
                                            color: Color(0xFF1E1E1E),
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
                                child: GestureDetector(
                                  onTap: () { 
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CategoriasPage())
                                    );    
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.add,
                                      color: GlobalColors.red,
                                      size: 36
                                    )
                                  )
                                )
                              )
                            ]
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child:  SizedBox(
                              height: 86,
                              child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data![1].length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                      Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => CategoriaPage(snapshot.data![1][index]['id'])),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
                                    width: 100,
                                    height: 70,                               
                                    decoration: BoxDecoration(
                                      color: GlobalColors.blue,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x6D000000),
                                          offset: Offset(0, 4),
                                          blurRadius: 4
                                        )
                                      ],
                                      border: Border.all(
                                        width: 3,
                                        color: GlobalColors.blue
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: LayoutBuilder(
                                                      builder: (BuildContext context, BoxConstraints constraints) {
                                                        return FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            '${snapshot.data![1][index]['name']}',
                                                            style: const TextStyle(
                                                              color: Color(0xFFFFFFFF),
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14
                                                            )
                                                          )
                                                        );
                                                      }
                                                    )
                                                  )
                                                )
                                              ]
                                            )
                                          ]
                                        )
                                      )
                                    )
                                  );
                                }
                              )
                              )
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: LayoutBuilder(
                                      builder: (BuildContext context, BoxConstraints constraints) {
                                        return const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Destaques',
                                            style: TextStyle(
                                              color: Color(0xFF1E1E1E),
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
                                  child: GestureDetector(
                                    onTap: () { 
                                      Navigator.pushNamed(
                                        context,
                                        '/Listagem'
                                      );    
                                    },
                                    child: LayoutBuilder(
                                      builder: (BuildContext context, BoxConstraints constraints) {
                                        return const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Ver todas',
                                            style: TextStyle(
                                              color: Color(0xFF848484),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12
                                            )
                                          )
                                        );
                                      }
                                    )
                                  )
                                )
                              ]
                            ),
                            const SizedBox(height: 30),
                            CarouselSlider.builder(   
                              itemCount: 1,
                              itemBuilder: (BuildContext context, index, itemIndex) {
                               return GridView.builder(
                                itemCount: 2,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1 / 1.6,
                                ), 
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProdutoPage(dados: snapshot.data![0][index])
                                            )
                                          );
                                        },
                                        child: Container(              
                                          height: 223,
                                          width: 260,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                                              color: const Color(0xFFD9D9D9),
                                              image: DecorationImage(
                                              image: obterImagem(snapshot.data![0][index]['images']),
                                              fit: BoxFit.fitWidth                                                                            
                                            )                  
                                          )
                                        )
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                LayoutBuilder(
                                                    builder: (BuildContext context, BoxConstraints constraints) {
                                                      return Container(
                                                        constraints: const BoxConstraints(),
                                                        alignment: Alignment.center,
                                                          child: Text(
                                                          '${snapshot.data![0][index]['name']}',
                                                          maxLines: 2,                         
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            color: Color(0xFF000000),
                                                            fontWeight: FontWeight.bold,
                                                          fontSize: 16
                                                        )
                                                      )
                                                    );
                                                  }
                                                )
                                              ]
                                            )
                                          )
                                        ]
                                      )
                                    ]
                                    );
                                  },
                                ); 
                              },
                                options: CarouselOptions(
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 6),
                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {},
                                  scrollDirection: Axis.horizontal,
                                  height: 310
                                ),
                              ),
                              const SizedBox(height: 10),
                              CarouselSlider.builder(   
                                itemCount: 4,
                                itemBuilder: (BuildContext context, index, itemIndex) {
                                return GridView.builder(
                                  itemCount: 2,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1 / 1.6,
                                  ), 
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProdutoPage(dados: snapshot.data![0][index])
                                              )
                                            );
                                          },
                                          child: Container(              
                                            height: 223,
                                            width: 260,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                                                color: const Color(0xFFD9D9D9),
                                                image: DecorationImage(
                                                image: obterImagem(snapshot.data![0][index]['images']),
                                                fit: BoxFit.fitWidth                                                                            
                                              )                  
                                            )
                                          )
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  LayoutBuilder(
                                                      builder: (BuildContext context, BoxConstraints constraints) {
                                                        return Container(
                                                          constraints: const BoxConstraints(),
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            '${snapshot.data![0][index]['name']}',
                                                            maxLines: 2,                         
                                                            textAlign: TextAlign.center,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              color: Color(0xFF000000),
                                                              fontWeight: FontWeight.bold,
                                                            fontSize: 16
                                                          )
                                                        )
                                                      );
                                                    }
                                                  )
                                                ]
                                              )
                                            )
                                          ]
                                        )
                                      ]
                                    );
                                  },
                                ); 
                              },
                              options: CarouselOptions(
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 6),
                                autoPlayAnimationDuration: Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {},
                                scrollDirection: Axis.horizontal, 
                                height: 310
                              ),
                            )
                          ]
                        );
                      }
                    }
                  )
            )
          )
        )
      ),
      bottomNavigationBar: const Footer()
    );
  }

  Future<List<dynamic>> mostrar() async {
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
      Map<String, dynamic> products = jsonDecode(response.body);      
      return products['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro');
  }

  Future<List<dynamic>> mostrarCategorias() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final url = Uri.parse('http://127.0.0.1:8000/api/categories');
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
      'Content-Type': 'application/json'
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> products = jsonDecode(response.body);
      return products['data'];
    } else if(response.statusCode == 404) {
      Map<String, dynamic> error = jsonDecode(response.body);
      throw Exception(error['message']);
    }

    throw Exception('Ocorreu um erro ao retornar as categorias');
  }

  Future<void> perfil() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client = http.Client();
    var url = Uri.parse('http://127.0.0.1:8000/api/user');

    final headers = {'Authorization': '${sharedPreference.getString("token")}'};

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> user = json.decode(response.body);

      return user['data'];
    }

    throw Exception('Erro ao carregar os dados do Usuário');
  }
}