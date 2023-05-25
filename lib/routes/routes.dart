import 'package:flutter/material.dart';
import 'package:deltasports_app/carrinho.dart';
import 'package:deltasports_app/index.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/perfil.dart';
import 'package:deltasports_app/produtos.dart';
import 'package:deltasports_app/sing_up.dart';
import 'package:deltasports_app/listagem.dart';
import 'package:deltasports_app/home.dart';
import 'package:deltasports_app/produto.dart';
import 'package:deltasports_app/editperfil.dart';
import 'package:deltasports_app/endereco/endereco.dart';

class AppPage {
  static final Map<String, WidgetBuilder> routes = {
    '/'           : (context) => const IndexPage(),
    '/Registrar'  : (context) => const RegisterPage(),
    '/Login'      : (context) => const Login(),
    '/Home'       : (context) => const HomePage(),
    '/Produtos'   : (context) => const ProdutosPage(),
    '/Produto'    : (context) => ProdutoPage(dados: const {}),
    '/Listagem'   : (context) => const ListagemPage(foto: {}),
    '/Carrinho'   : (context) => const CarrinhoPage(),
    '/Perfil'     : (context) => const PerfilPage(),
    '/Editperfil' : (context) => const EditperfilPage(),
    '/Enderecos'  : (context) => const EnderecoPage(),
    /*'/Categorias':(context)       => HomePage(),
    
    '/NovoEnd':(context)       => NovoEndPage(),
    '/Checkout':(context)       => HomePage(),
    '/MeusPedidos':(context)       => PedidosPage(),
    '/Pedido':(context)       => DetPedidosPage(),*/
  };
}
