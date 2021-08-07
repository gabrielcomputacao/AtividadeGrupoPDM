import 'package:aulaconceitos/componentes/card_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.amberAccent]),
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 70),
                child: Text(
                  "VeiculosApp",
                  style: TextStyle(
                    color: Colors.black12,
                    fontSize: 40,
                  ),
                ),
              ),
              CardLogin()
            ],
          ),
        )
      ]),
    );
  }
}