import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic obterImagem(dynamic url) {
    if (url.length > 0 && url[0] != null && url[0]['url'] != '') {
      return NetworkImage(url[0]['url']);
    } else {
      return const AssetImage('images/no_image.png');
    }
  }

  Future<bool> verificarToker() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (sharedPreference.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }