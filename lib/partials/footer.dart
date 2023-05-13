import 'package:flutter/material.dart';

import '../carrinho.dart';
import '../listagem.dart';
import '../perfil.dart';
import '../produtos.dart';
import '../main.dart';
import '../utilis/global_colors.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0;
  final Color backgroundColor = GlobalColors.red;

  static const List<Widget> _widgetOptions = <Widget>[
    ListagemPage(foto: {}),
    ProdutosPage(),
    CarrinhoPage(),
    PerfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: const Color(0x8FFFFFFF),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
              backgroundColor: backgroundColor
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: 'Produtos',
              backgroundColor: backgroundColor
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.add_shopping_cart),
              label: 'Carrinho',
              backgroundColor: backgroundColor
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Perfil',
              backgroundColor: backgroundColor
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: GlobalColors.white,
          onTap: _onItemTapped,
        ), 
      )
    );
  }
}

/* 
 Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => IndexPage(),
                ),
              );





 */