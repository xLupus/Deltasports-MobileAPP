import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth * 0.85,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Image.network('https://i.imgur.com/aSEadiB.png')
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalColors.red,
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
                          onPressed: () { Navigator.of(context).pushNamed('/login');  }, 
                          child: const Text('Entrar'),
                        )
                      ),
                        
                      const SizedBox(height: 10),

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
                          onPressed: () { Navigator.of(context).pushNamed('/registrar');  }, 
                          child: const Text('Registrar'),
                        )
                      )
                    ]
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}
