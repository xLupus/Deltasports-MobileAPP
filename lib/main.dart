import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/index.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/perfil.dart';
import 'package:deltasports_app/produtos.dart';
import 'package:deltasports_app/sing_up.dart';
import 'package:deltasports_app/listagem.dart';
import 'package:flutter/material.dart';
import 'package:deltasports_app/home.dart';
import 'package:deltasports_app/produto.dart';

import 'editperfil.dart';
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
        '/Produto':(context)    => ProdutoPage(dados: {},),
        '/Listagem':(context)      => ListagemPage(foto: {},),
        '/Carrinho':(context)   => CarrinhoPage(),
        '/Perfil':(context)       => PerfilPage(),
        '/Editperfil':(context) =>   EditperfilPage(),
        /*'/Categorias':(context)       => HomePage(),
        '/Endereços':(context)       => EnderecoPage(),
        '/NovoEnd':(context)       => NovoEndPage(),
        '/Checkout':(context)       => HomePage(),
        '/MeusPedidos':(context)       => PedidosPage(),
        '/Pedido':(context)       => DetPedidosPage(),*/
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
