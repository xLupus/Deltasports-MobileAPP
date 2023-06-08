import 'package:deltasports_app/categoria/categorias.dart';
import 'package:flutter/material.dart';

import 'package:deltasports_app/pedido/pedidos.dart';
import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/index/index.dart';
import 'package:deltasports_app/auth/login_page.dart';
import 'package:deltasports_app/perfil/perfil.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:deltasports_app/auth/sing_up.dart';
import 'package:deltasports_app/index/listagem.dart';
import 'package:deltasports_app/index/home.dart';
import 'package:deltasports_app/produto/produto.dart';
import 'package:deltasports_app/perfil/editperfil.dart';
import 'package:deltasports_app/endereco/endereco.dart';
class AppPage {
  static final Map<String, WidgetBuilder> routes = {
    '/'             : (context) => const IndexPage(),
    '/Registrar'    : (context) => const RegisterPage(),
    '/Login'        : (context) => const Login(),
    '/Home'         : (context) => const HomePage(),
    '/Produtos'     : (context) => const ProdutosPage(),
    '/Produto'      : (context) => ProdutoPage(dados: const {}),
    '/Listagem'     : (context) => const ListagemPage(foto: {}),
    '/Carrinho'     : (context) => const CarrinhoPage(),
    '/Perfil'       : (context) => const PerfilPage(),
    '/Editperfil'   : (context) => const EditperfilPage(),
    '/Enderecos'    : (context) => const EnderecoPage(),
    '/MeusPedidos'  : (context) => const PedidosPage(dados: {},),
    '/Categorias'   : (context) => const CategoriasPage()
  };
}
