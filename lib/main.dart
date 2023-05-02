import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/index.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/produtos.dart';
import 'package:deltasports_app/sing_up.dart';
import 'package:deltasports_app/listagem.dart';
import 'package:flutter/material.dart';
import 'package:deltasports_app/home.dart';
import 'package:deltasports_app/produto.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':(context)           => IndexPage(),
        '/Registrar':(context)  => RegisterPage(),
        '/Login':(context)      => LoginPage(),
        '/Home':(context)       => HomePage(),
        '/Produtos':(context)   => ProdutosPage(),
        '/Produto':(context)    => ProdutoPage(foto: {},),
        '/Listagem':(context)      => ListagemPage(foto: {},),
        '/Carrinho':(context)   => CarrinhoPage(),
        /*'/Categorias':(context)       => HomePage(),
        '/Perfil':(context)       => HomePage(),
        '/EditarPerfil':(context)       => HomePage(),
        '/Endereços':(context)       => HomePage(),
        '/NovoEnd':(context)       => HomePage(),
        '/Filtros':(context)       => HomePage(),
        '/Checkout':(context)       => HomePage(),
        '/MeusPedidos':(context)       => HomePage(),
        '/Pedido':(context)       => HomePage(),*/
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
