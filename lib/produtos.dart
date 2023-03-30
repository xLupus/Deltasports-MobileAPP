import 'package:deltasports_app/utilis/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:deltasports_app/utilis/footer.dart';


class ProdutosPage extends StatefulWidget {
  const ProdutosPage({Key? key}) : super(key: key);

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 20),

            //Logo E Search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.network('https://i.imgur.com/ell1sHu.png'),
                Icon(
                  Icons.search,
                  color: GlobalColors.red,
                  size: 45.0,
                ),
              ],
            ),


            SizedBox(height: 50),
            //Titulo "Produtos e ADD"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Produtos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Icon(
                  Icons.add,
                  color: GlobalColors.red,
                  size: 45.0,
                ),
              ],
            ),


            SizedBox(height: 10),
            //Categorias
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //Tênis
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 05.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed(
                        '/Registrar'
                      )
                    },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                    decoration: BoxDecoration(
                      color: GlobalColors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Tênis',
                        style: TextStyle(
                          color: GlobalColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                ),//Fim_Tenis

                //Roupas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 05.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed(
                        '/Registrar'
                      )
                    },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                    decoration: BoxDecoration(
                      color: GlobalColors.blue,
                      borderRadius: BorderRadius.circular(12),
 
                    ),
                    child: Center(
                      child: Text(
                        'Roupas',
                        style: TextStyle(
                          color: GlobalColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                ),//Fim Roupas

                //Acessórios
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 05.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed(
                        '/Registrar'
                      )
                    },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                    decoration: BoxDecoration(
                      color: GlobalColors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Acessórios',
                        style: TextStyle(
                          color: GlobalColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                ),//Fim Acessórios

                //Bolas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 05.0),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushReplacementNamed(
                        '/Registrar'
                      )
                    },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20,10,20,10),
                    decoration: BoxDecoration(
                      color: GlobalColors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Bolas',
                        style: TextStyle(
                          color: GlobalColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                ),//Fim Bolas

              //Adicionar restante da categoria
              ],
            ),


//Footer


  
//Final Footer



          ]),
        ),
      ),
    );
  }
}
