// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:deltasports_app/pages/login.dart';
import 'package:deltasports_app/pages/signup.dart';
import 'package:deltasports_app/utilis/global.colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}): super(key: key);

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 200,),
              Image.network('https://i.imgur.com/aSEadiB.png'),
              SizedBox(height: 150,),

            //Btn Login
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).pushReplacementNamed(
                    '/Login'
                  )
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GlobalColors.red,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:  [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),

              SizedBox(height: 30,),

            //Btn Login
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).pushReplacementNamed(
                    '/Login'
                  )
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GlobalColors.blue ,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:  [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                  ),
                  child: Center(
                    child: Text(
                      'Registrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
              
            ],
          ), 
        ),
      );  
    } //Widget

}


  