import 'package:deltasports_app/perfil.dart';
import 'package:deltasports_app/produtos.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'carrinho.dart';
import 'index.dart';
import 'listagem.dart';

/* class EnderecoPage extends StatefulWidget {
  const EnderecoPage({Key? key}) : super(key: key);

  @override
  State<EnderecoPage> createState() => EnderecoPageState();
}

class EnderecoPageState extends State<EnderecoPage> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if(1 == 1) print('i');
  }
} */

class MostrarEnderecosPage extends StatefulWidget {
  const MostrarEnderecosPage({Key? key}) : super(key: key);

  @override
  State<MostrarEnderecosPage> createState() => MostrarEnderecosPageState();
}

class MostrarEnderecosPageState extends State<MostrarEnderecosPage> {
   final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Column(
                  children: [
                    Image.network('https://i.imgur.com/ell1sHu.png')
                  ]
                )
              ),
              Form(
                key: _formkey,
                child: Container(
                  width: screenWidth * 0.75,
                  margin: const EdgeInsets.only(top: 250),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Novo Endereço:',
                                style: TextStyle(
                                  color: Color(0xFF3D3D3D),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(height: screenHeight * 0.025),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Logradouro',
                              ),
                            )
                          ),
                        ],
                      ),
                       Row(
                        children: [
                          SizedBox(height: screenHeight * 0.025),
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Complemento',
                              ),
                            )
                          ),
                          const Spacer(),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Nº',
                              ),
                            )
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'CEP',
                              ),
                            )
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Cidade',
                              ),
                            )
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 3,
                            child:  TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Estado',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(height: screenHeight * 0.025),
                          Expanded(
                            flex: 3,
                            child:  TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Nome',
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.3),

                      Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalColors.blue,
                              padding: const EdgeInsets.all(10.0),
                              fixedSize: Size(screenWidth * 0.75, 55.0),
                              textStyle: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                              ),
                              elevation: 20.0,            
                              shadowColor: const Color(0xD2000000),                
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              side: BorderSide(color: GlobalColors.blue, width: 3)
                            ),
                            onPressed: () { Navigator.of(context).pushNamed('/'); }, 
                            child: const Text('Salvar')
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),

      //footter
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

}