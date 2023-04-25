import 'package:flutter/material.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:deltasports_app/login_page.dart';

class ProdutoPage extends StatefulWidget {

  Map<String, dynamic> foto;

  ProdutoPage({Key? key, required this.foto}) : super(key: key);

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foto['title']),
      ),
      body: ListView(
        children: [
          Image.network(widget.foto['http://127.0.0.1:8000/api/products'], fit: BoxFit.cover,),
          Text(widget.foto['title']),
        ],
      ),
    );
  }
}