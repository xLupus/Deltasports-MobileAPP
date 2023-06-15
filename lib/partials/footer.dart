import 'package:flutter/material.dart';
import '../utilis/global_colors.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => FooterState();
}

class FooterState extends State<Footer> {
  int _selectedIndex = 0;
  final Color backgroundColor = GlobalColors.red;
  //PageController _pageController = PageController();
  
  final List<String> _screens = [
    '/Produtos',
    '/Listagem',
    '/Carrinho',
    '/Perfil'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.of(context).pushNamed(_screens[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
                color: Color(0x6D000000),
                offset: Offset(0, 4),
                blurRadius: 14,
                spreadRadius: 6
              )
            ],
          borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: const Color(0x8FFFFFFF),
          items: <BottomNavigationBarItem> [
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
        )
      ),
    );
  }
}