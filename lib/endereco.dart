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
          child:  SizedBox(
            height: screenHeight,
            child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight < 800 ? screenHeight * 0.3 : screenHeight * 0.07),

                    Image.network('https://i.imgur.com/ell1sHu.png'),
                  ],
                ),
              ),           
              Form(
                key: _formkey,
                child:  Container(
                  width: screenWidth * 0.75,
                  margin: const EdgeInsets.only(top: 250),
                  child: Row(
                    children: [
                      Expanded(
                        child:  
                          Column(
                            children: [
                              TextFormField(
                                initialValue: '12345678',
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                ),
                              ),
                            ],
                          )
                        ),
                        Expanded(
                          child: 
                          Column(
                            children: [
                            //Senha
                            TextFormField(
                              initialValue: '12345678',
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                              ),
                            ),
                          ],
                        )
                      ),
                      Expanded(
                          child: 
                          Column(
                            children: [
                            //Senha
                            TextFormField(
                              initialValue: '12345678',
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 230,
                child: SizedBox(
                  width: screenWidth * 0.75,
                  child: Column(
                    children: [
                     ElevatedButton(               
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                        ),
                        onPressed: () { /*if (_formkey.currentState!.validate()) login(); */ }, 
                        child: const Text('Salvar'),
                      ),
                    ],
                  ),
                )
              )
            ]
          ),
       ),
     ),
    ),
  );
}
}