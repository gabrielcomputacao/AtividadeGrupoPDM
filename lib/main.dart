import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'api/jogador.dart';
import 'api/jogo.dart';
import 'screen/inicial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => JogoController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => JogadorController(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Uno',
        theme: ThemeData(primaryColor: Colors.blue),
        home: Inicial(),
      ),
    );
  }
}
