import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../endereco/criar_endereco.dart';

Future<List<dynamic>> getCep(cep) async {
/*   final TextEditingController _logradouroController   = TextEditingController();
  final TextEditingController _complementoController  = TextEditingController();
  final TextEditingController _numeroController       = TextEditingController();
  final TextEditingController _cepController          = TextEditingController();
  final TextEditingController _cidadeController       = TextEditingController();
  final TextEditingController _estadoController       = TextEditingController();
  final TextEditingController _tipoController         = TextEditingController(); */

  final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('error')) {
      print('CEP não encontrado');
    }

    List address = [
      data['cep'],
      data['logradouro'],
      data['complemento'],
      data['localidade'],
      data['uf']
    ];
    print(address);
    return address;
  } else if (response.statusCode == 400) {
    print('Cep inválido');
  }

  throw Exception('Não foi possível retornar o CEP');
}
