import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    Image.network('https://i.imgur.com/ell1sHu.png'),
                  ],
                ),
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
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'CEP',
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
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}