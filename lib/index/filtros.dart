import 'dart:convert';
import 'package:deltasports_app/categoria/categoria.dart';
import 'package:deltasports_app/partials/footer.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../partials/header.dart';

class FiltrosPage extends StatefulWidget {
  const FiltrosPage({Key? key}) : super(key: key);

  @override
  State<FiltrosPage> createState() => FiltrosPageState();
}

class FiltrosPageState extends State<FiltrosPage> {
  late Future<dynamic> _data;

  @override
  Widget build(BuildContext context) {
    double screenWidth    = MediaQuery.of(context).size.width;
    double screenHeight   = MediaQuery.of(context).size.height;

    setState(() { _data = mostrarCategorias(); });

    return Scaffold(
       backgroundColor: GlobalColors.white,
       body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.85,
            child: Column(
              children: [
                const SizedBox(
                  height: 135,
                  child: HeaderThree(),
                ),
                Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: GlobalColors.red,
                                        width: 5
                                      )
                                    )
                                  ),
                                  child: LayoutBuilder(
                                  builder: (BuildContext context, BoxConstraints constraints) {
                                    return const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Filtros',
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
                            )
                          ),     
                    ],
                  ),
                const SizedBox(height: 30),
                FutureBuilder(
                  future: _data,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: screenHeight - 259,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFBABABA),
                                  ),
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
                                height: screenHeight - 259,
                                child: Center(
                                  child: Text(
                                    snapshot.error.toString().substring(11),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    )
                                  ),
                                )
                              )
                            );
                          }
                        ); 
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.7,
                            height: 260,
                            child: GridView.builder(
                            shrinkWrap: true,
                              itemCount: snapshot.data.length,
                                scrollDirection: Axis.horizontal,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 20,
                                childAspectRatio: 1.15 / 1.7
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                      Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => CategoriaPage(snapshot.data[index]['id'])),
                                    );
                                  },
                                  child: Container(         
                                          margin: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: GlobalColors.blue,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x6D000000),
                                          offset: Offset(0, 4),
                                          blurRadius: 4
                                        )
                                      ],
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: 
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Center(
                                                  child: LayoutBuilder(
                                                      builder: (BuildContext context, BoxConstraints constraints) {
                                                        return FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Text(
                                                            '${snapshot.data[index]['name']}',
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.center,
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
                                          
                                        
                                      ),
                                  
                                    )
                                  );
                                
                                }
                              
                              ),
                          ),
                            
                           const SizedBox(height: 50),
                           Row(
                            children: [
                              Expanded(
                                child:Align(
                                    alignment: Alignment.centerLeft,
                                    child: LayoutBuilder(
                                      builder: (BuildContext context, BoxConstraints constraints) {
                                        return const FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Ordenar Por:',
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
                            ]
                           ),
                           const SizedBox(height: 20),
                           SizedBox(
                              height: 60,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                    GestureDetector(
                                    onTap: () {
                                       //
                                    },
                                    child: Container(
                                       margin: const EdgeInsets.only(bottom: 6),
                                      width: 115,
                                      height: 40,                             
                                      decoration: BoxDecoration(
                                        color: GlobalColors.white,
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
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: 
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return const FittedBox(
                                                            fit: BoxFit.scaleDown,
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              'A-Z',
                                                              style:  TextStyle(
                                                                color: Color(0xFF000000),
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16
                                                              )
                                                            )
                                                          );
                                                        }
                                                      )
                                                    )
                                                  )
                                                ]
                                              ),
                                        )
                                      )
                                    ),
                                     const SizedBox(width: 10),
                                     GestureDetector(
                                    onTap: () {
                                       //
                                    },
                                    child: Container(
                                       margin: const EdgeInsets.only(bottom: 6),
                                      width: 115,
                                      height: 40,                             
                                      decoration: BoxDecoration(
                                        color: GlobalColors.white,
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
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: 
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return const FittedBox(
                                                            fit: BoxFit.scaleDown,
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              'Z-A',
                                                              style:  TextStyle(
                                                                color: Color(0xFF000000),
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16
                                                              )
                                                            )
                                                          );
                                                        }
                                                      )
                                                    )
                                                  )
                                                ]
                                              ),
                                        )
                                      )
                                    ),
                                     const SizedBox(width: 10),
                                     GestureDetector(
                                    onTap: () {
                                       //
                                    },
                                    child: Container(
                                       margin: const EdgeInsets.only(bottom: 6),
                                      width: 115,
                                      height: 40,                             
                                      decoration: BoxDecoration(
                                        color: GlobalColors.white,
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
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: 
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return const FittedBox(
                                                            fit: BoxFit.scaleDown,
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              'Maiores preços',
                                                              style:  TextStyle(
                                                                color: Color(0xFF000000),
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16
                                                              )
                                                            )
                                                          );
                                                        }
                                                      )
                                                    )
                                                  )
                                                ]
                                              ),
                                        )
                                      )
                                    ),
                                     const SizedBox(width: 10),
                                     GestureDetector(
                                    onTap: () {
                                       //
                                    },
                                    child: Container(
                                       margin: const EdgeInsets.only(bottom: 6),
                                      width: 115,
                                      height: 40,                             
                                      decoration: BoxDecoration(
                                        color: GlobalColors.red,
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
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: 
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: LayoutBuilder(
                                                        builder: (BuildContext context, BoxConstraints constraints) {
                                                          return const FittedBox(
                                                            fit: BoxFit.scaleDown,
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              'Menores preços',
                                                              style:  TextStyle(
                                                                color: Color(0xFFFFFFFF),
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16
                                                              )
                                                            )
                                                          );
                                                        }
                                                      )
                                                    )
                                                  )
                                                ]
                                              ),
                                        )
                                      )
                                    ),
                                ],
                                )
                              ),
                          SizedBox(
                            height: screenHeight - 680,
                            child:  Center(
                              child:  ElevatedButton(               
                            style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalColors.blue,
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
                            onPressed: () { 
                              /*  TODO: FILTROS*/
                                Navigator.of(context).pop();
                            },
                            child: const Text('Aplicar')
                          ),
                            )
                          )
                      
                              

                        ],
                      );
                    }
                  }
                )
              ]
            )
          )
        )
      ),
      bottomNavigationBar: const Footer(),
    );
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
}