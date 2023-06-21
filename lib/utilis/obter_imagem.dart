import 'package:flutter/material.dart';

dynamic obterImagem(dynamic url) {
  if (url.length > 0 && url[0] != null && url[0]['url'] != '') {
      return NetworkImage(url[0]['url']);
  } else {
    return const AssetImage('images/no_image.png');
  }
}

dynamic obterImagemPesquisa(dynamic url) {
  if (url.length > 0 && url[0] != null && url[0]['url'] != '') {
    return Image(image: NetworkImage(url[0]['url']));
  } else {
   return const Image(image: AssetImage('images/no_image.png'));
  }
}