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
          child: Column(children: [
            SizedBox(height: 150),
            Image.network('https://i.imgur.com/aSEadiB.png'),
            SizedBox(height: 205),

            //Btn Login
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).pushReplacementNamed(
                    '/Login'
                  )
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GlobalColors.red,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:  [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: GlobalColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            //Btn Registrar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).pushReplacementNamed(
                    '/Registrar'
                  )
                },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: GlobalColors.blue,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:  [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      color: GlobalColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            ),
          ]),
        ),
      ),
    );
  }
}
