import 'package:flutter/material.dart';
import 'package:deltasports_app/login_page.dart';
import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() => runApp(ProfileScreen());


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores de texto com os valores atuais do usuário
    _nameController = TextEditingController(text: 'John Doe');
    _emailController = TextEditingController(text: 'johndoe@gmail.com');
  }

  @override
  void dispose() {
    // Descarta os controladores de texto quando a tela é fechada
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Digite seu nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'E-mail',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Digite seu e-mail',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Salva as alterações do usuário
          _saveChanges();
          // Mostra uma mensagem de sucesso ao usuário
          _showSuccessMessage();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void _saveChanges() {
    // Salva as alterações do usuário em algum lugar
    String name = _nameController.text;
    String email = _emailController.text;
    // Por exemplo, você pode salvar em um banco de dados ou em uma API
    // Aqui, vamos imprimir os valores no console para demonstração
    print('Nome: $name');
    print('E-mail: $email');
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('As alterações foram salvas com sucesso.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
