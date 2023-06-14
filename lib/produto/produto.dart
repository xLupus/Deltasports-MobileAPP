import 'package:flutter/material.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart' as intl;

import '../carrinho/carrinho.dart';
import '../partials/footer.dart';
import '../utilis/obter_imagem.dart';

class ProdutoPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProdutoPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ProdutoPage> createState() => ProdutoPageState();
}

class ProdutoPageState extends State<ProdutoPage> {
  int _qtdController = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth    = MediaQuery.of(context).size.width;
    double screenHeight   = MediaQuery.of(context).size.height;

    setQtd(int value) => setState(() {
      _qtdController = value;
    });

    final double _priceTotal = double.parse(widget.data['price']) - double.parse(widget.data['discount']);

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: screenHeight,
            child: Stack(
              children: [
                 Positioned(
                  child: Container(
                    height: 600,
                    width: screenWidth,
                    decoration: BoxDecoration(                       
                      color: const Color(0xFFD9D9D9),
                      image: DecorationImage(
                      image: obterImagem(widget.data['images']),
                        fit: BoxFit.fitWidth                                                                            
                      )                  
                    )
                  ),
                ),
               Positioned(
                bottom: -5,
                 child: Center(
                   child: ClipRRect(
                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                       child: Container(
                        color: Color.fromARGB(255, 180, 180, 180),
                         width: screenWidth,
                         height: screenHeight - 550,
                         child: Column(
                           children: [
                             SizedBox(
                               width: screenWidth * 0.85,
                               child:  Column(
                         children: [
                           const SizedBox(height: 30),
                           Row(
                             children: [
                               Expanded(
                                 child:   LayoutBuilder(
                                           builder: (BuildContext context, BoxConstraints constraints) {
                                             return Container(
                                               constraints: const BoxConstraints(),
                                               alignment: Alignment.center,
                                               child: Text(
                                                 widget.data['name'],
                                                 maxLines: 2,                         
                                                 textAlign: TextAlign.center,
                                                 overflow: TextOverflow.ellipsis,
                                                 style: const TextStyle(
                                                   color: Color(0xFF1E1E1E),
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: 22
                                                 )
                                               )
                                             );
                                           }
                                 ),
                               )
                             ],
                           ),
                           const SizedBox(height: 20),
                           Row(
                             children: [
                               SizedBox(
                                 width: 105,
                                 height: 38,
                                 child:  LayoutBuilder(
                                              builder: (BuildContext context, BoxConstraints constraints) {
                                                return  Container(          
                                                  padding: const EdgeInsets.all(8),                                  
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xFFD9D9D9),
                                                    borderRadius: BorderRadius.all(Radius.circular(14.0))
                                                  ),
                                                  constraints: const BoxConstraints(),
                                                  alignment: Alignment.center,
                                                  child: Row(
                                   children: [
                                     Expanded(
                                        child:  GestureDetector(
                                                  onTap: () { 
                                                    if (_qtdController > 1) {
                                             setQtd(_qtdController - 1);
                                           }
                                                  },
                                                  child:const Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 22
                                                    )
                                                  )
                                        )
                                     ),
                                   Text(
                                            '$_qtdController',
                                            maxLines: 2,                         
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                            )
                                          ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () { 
                                        if (_qtdController < widget.data['stock']) {
                                            setQtd(_qtdController + 1);
                                          }
                                        },
                                        child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.add,
                                            size: 22
                                          )
                                        )
                                      )
                                    )
                                  ]
                                )
                                                );
                                 
                                 
                                 
                                              }
                                )
                                ),
                                const SizedBox(width: 10),
                               Expanded(
                                 child: LayoutBuilder(
                                   builder: (BuildContext context, BoxConstraints constraints) {
                                     return Container(
                                       constraints: const BoxConstraints(),
                                       alignment: Alignment.centerLeft,
                                       child: const Text(
                                         'Unidades',                        
                                         overflow: TextOverflow.ellipsis,
                                         style: TextStyle(
                                           color: Color(0xFF1E1E1E),
                                           fontWeight: FontWeight.w400,
                                           fontSize: 18
                                         )
                                       )
                                     );
                                   }
                                 )
                               )
                             ],
                           ),
                           const SizedBox(height: 15),
                           Row(
                             children: [
                               Expanded(
                                 child: LayoutBuilder(
                                 builder: (BuildContext context, BoxConstraints constraints) {
                                   return Container(
                                     constraints: const BoxConstraints(),
                                     child: Text(
                                       widget.data['description'],   
                                       maxLines: 2,                        
                                       overflow: TextOverflow.ellipsis,
                                       style: const TextStyle(
                                         color: Color(0xFF3A3A3A),
                                           fontWeight: FontWeight.w400,
                                           fontSize: 16
                                         )
                                       )
                                     );
                                   }
                                 )
                               )
                             ]
                           ),
                           const SizedBox(height: 20),
                           Row(
                             children: [
                               Flexible(
                                 child: LayoutBuilder(
                                                   builder: (BuildContext context, BoxConstraints constraints) {
                                                     return Container(
                                                       constraints: const BoxConstraints(),
                                           
                                                       child: Text(
                                                         intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(double.parse(widget.data['price'])),   
                                                         maxLines: 2,           
                                                         overflow: TextOverflow.ellipsis,
                                                         style: const TextStyle(
                                                           color: Color(0xFF1E1E1E),
                                                           fontWeight: FontWeight.bold,
                                                           fontSize: 22
                                                         )
                                                       )
                                                     );
                                                   }
                                 ),
                               ),
                               const SizedBox(width: 20),
                               Flexible(
                                 child: LayoutBuilder(
                                                   builder: (BuildContext context, BoxConstraints constraints) {
                                                     return Container(
                                                       constraints: const BoxConstraints(),
                                                       child: Text(
                                                         intl.NumberFormat.currency(locale: 'pt_BR', name: 'R\$').format(_priceTotal),   
                                                         maxLines: 2,          
                                                         overflow: TextOverflow.ellipsis,
                                                         style: const TextStyle(
                                                           color: Color(0xFF1E1E1E),
                                                           fontWeight: FontWeight.bold,
                                                           fontSize: 22
                                                         )
                                                       )
                                                     );
                                                   }
                                 ),
                               )
                             ],
                           ),
                           const SizedBox(height: 20),
                           Container(
                                       margin: const EdgeInsets.only(bottom: 20.0),
                                       child: ElevatedButton(
                                         style: ElevatedButton.styleFrom(
                                           backgroundColor: GlobalColors.blue,
                                           padding: const EdgeInsets.all(10.0),
                                           fixedSize: Size(screenWidth * 0.85, 55.0),
                                           foregroundColor: GlobalColors.white,
                                           textStyle: const TextStyle(
                                             fontSize: 24.0,
                                             fontWeight: FontWeight.w700,
                                           ),
                                           elevation: 20.0,            
                                           shadowColor: const Color(0xD2000000),                
                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                                         ),
                                         onPressed: () { 
                                           AdicionarCart();
                                         //  Navigator.of(context).pushNamed('/Carrinho'); 
                                           }, 
                                         child: const Text('Adicionar ao Carrinho')
                                       ),
                                     ),
                                     Row(
                                       children: [
                                         Expanded(
                                           child: GestureDetector(
                                             onTap: () {
                                               Navigator.of(context).pushNamed('/Produtos');
                                             },
                                             child: LayoutBuilder(
                                                   builder: (BuildContext context, BoxConstraints constraints) {
                                                     return Container(
                                                       constraints: const BoxConstraints(),
                                                       child: const Text(
                                                         'Voltar a Produtos',                      
                                                         textAlign: TextAlign.center,
                                                         overflow: TextOverflow.ellipsis,
                                                         style: TextStyle(
                                                           color: Color(0xFF3D3D3D),
                
                                                           fontSize: 16
                                                         )
                                                       )
                                                     );
                                                   }
                                 ),
                                           )
                               ),
                                         
                                       ],
                                     )
                         ],
                       ),
                             )
                           ],
                         )
                       )
                   ) 
                 ),
               )
              ],
            ),
          ),
        )
      ),

      bottomNavigationBar: const Footer(),
    );
  }


  Future<bool> AdicionarCart() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var client = http.Client();
    final headers = {
      'Authorization': '${sharedPreference.getString("token")}',
    };
    final url = Uri.parse('http://127.0.0.1:8000/api/user/cart');

    print([widget.data['id'], widget.data['stock']]);

    var resposta = await client.post(url,
        body: {
          'product': widget.data['id'].toString(),
          'qtd': _qtdController.toString()
        },
        headers: headers);

    print(resposta);

    if (resposta.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CarrinhoPage()),
      );

      print(convert.jsonDecode(resposta.body));

      return true;
    } else {
      return false;
    }
  }
}
