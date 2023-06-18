import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: screenHeight < 800 ? screenHeight * 0.3 : screenHeight * 0.35),

                  Image.network('https://i.imgur.com/aSEadiB.png'),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              child: SizedBox(
                width: screenWidth * 0.75,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalColors.red,
                        padding: const EdgeInsets.all(10.0),
                        fixedSize: Size(screenWidth * 0.75, 55.0),
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
                      child: const Text('Login'),
                    ),
                    
                    SizedBox(height: screenHeight * 0.045),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalColors.blue,
                          padding: const EdgeInsets.all(10.0),
                          fixedSize: Size(screenWidth * 0.75, 55.0),
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
                  ],
                ),
              )
            )
          ]
        ),
      )
    );
  }
}
