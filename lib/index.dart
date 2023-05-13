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
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 277.0),

              Image.network('https://i.imgur.com/aSEadiB.png'),     

              const SizedBox(height: 242.0),

              ElevatedButton(               
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.red,
                  padding: const EdgeInsets.all(10.0),
                  fixedSize: const Size(355.0, 55.0),
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  elevation: 20.0,
                  shadowColor: const Color(0xD2000000),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                ),
                onPressed: () { Navigator.of(context).pushNamed('/Login'); }, 
                child: const Text('Entrar'),
              ),
             
              const SizedBox(height: 40.0),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.blue,
                  padding: const EdgeInsets.all(10.0),
                  fixedSize: const Size(355.0, 55.0),
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  elevation: 20.0,            
                  shadowColor: const Color(0xD2000000),                
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                ),
                onPressed: () { Navigator.of(context).pushNamed('/Registrar'); }, 
                child: const Text('Registrar')
              )
            ]
          )
        )
      )
    );
  }
}