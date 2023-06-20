import 'package:deltasports_app/carrinho/checkout.dart';
import 'package:deltasports_app/categoria/categorias.dart';
import 'package:deltasports_app/index/filtros.dart';
import 'package:flutter/material.dart';

import 'package:deltasports_app/pedido/pedidos.dart';
import 'package:deltasports_app/carrinho/carrinho.dart';
import 'package:deltasports_app/index/index.dart';
import 'package:deltasports_app/auth/login.dart';
import 'package:deltasports_app/perfil/perfil.dart';
import 'package:deltasports_app/index/home.dart';
import 'package:deltasports_app/auth/registrar.dart';
import 'package:deltasports_app/produto/produtos.dart';
import 'package:deltasports_app/produto/produto.dart';
import 'package:deltasports_app/perfil/editar_perfil.dart';
import 'package:deltasports_app/endereco/enderecos.dart';

class AppPage {
  static final Map<String, WidgetBuilder> routes = {
    '/'             : (context) => const IndexPage(),
    '/home'         : (context) => const HomePage(),
    '/registrar'    : (context) => const RegistroPage(),
    '/produtos'     : (context) => const ProdutosPage(),
    '/login'        : (context) => const Login(),
    '/produto'      : (context) => const ProdutoPage(data: {}),
    '/carrinho'     : (context) => const CarrinhoPage(),
    '/perfil'       : (context) => const PerfilPage(),
    '/editarPerfil' : (context) => const EditarPerfilPage(),
    '/enderecos'    : (context) => const EnderecoPage(),
    '/pedidos'      : (context) => const PedidosPage(),
    '/categorias'   : (context) => const CategoriasPage(),
    '/filtros'      : (context) => const FiltrosPage(),
    '/checkout'     : (context) => const CheckoutPage()
  };
}
