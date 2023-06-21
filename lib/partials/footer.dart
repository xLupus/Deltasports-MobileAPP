import 'package:flutter/material.dart';
import '../utilis/global_colors.dart';

class Footer extends StatefulWidget {
  final int currentPageIndex;
  const Footer({Key? key,  required this.currentPageIndex}) : super(key: key);

  @override
  State<Footer> createState() => FooterState();
}

class FooterState extends State<Footer> {
  late PageController _pageController;
  int _selectedIndex = 0;
  final Color backgroundColor = GlobalColors.red;
  
  final List<String> _screens = [
    '/home',
    '/produtos',
    '/carrinho',
    '/perfil'
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentPageIndex;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(_screens[index]);
    });
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