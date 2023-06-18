import 'package:flutter/material.dart';

import '../produto/pesquisa.dart';
import '../index/home.dart';
import '../utilis/global_colors.dart';
/* 
class HeaderOne extends StatefulWidget {
  const HeaderOne({Key? key}) : super(key: key);

  @override
  State<HeaderOne> createState() => HeaderOneState();
}

class HeaderOneState extends State<HeaderTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
        ]
      )
    );
  }
} */
//
class HeaderTwo extends StatefulWidget {
  const HeaderTwo({Key? key}) : super(key: key);

  @override
  State<HeaderTwo> createState() => HeaderTwoState();
}

class HeaderTwoState extends State<HeaderTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Container(
            margin: const EdgeInsets.only(top: 50, bottom: 50),
              child: GestureDetector(
                  onTap: () { 
                  Navigator.pushReplacement(
                    context,
                  MaterialPageRoute(builder: (context) => const HomePage())
                );
              },
              child: Image.network('https://i.imgur.com/ell1sHu.png')
            )
          ),
          IconButton(
            onPressed: () { showSearch(context: context, delegate: PesquisaPage()); },
            icon: Icon(
              Icons.search_rounded,
              color: GlobalColors.red,
              size: 29,
            ),
          )       
        ],
      )
    );
  }
}
//
class HeaderThree extends StatefulWidget {
  const HeaderThree({Key? key}) : super(key: key);

  @override
  State<HeaderThree> createState() => HeaderThreeState();
}

class HeaderThreeState extends State<HeaderThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           Container(
            margin: const EdgeInsets.only(top: 50, bottom: 50),
              child: GestureDetector(
                  onTap: () { 
                  Navigator.pushReplacement(
                    context,
                  MaterialPageRoute(builder: (context) => const HomePage())
                );
              },
              child: Image.network('https://i.imgur.com/ell1sHu.png')
            )
          )     
        ]
      )
    );
  }
}