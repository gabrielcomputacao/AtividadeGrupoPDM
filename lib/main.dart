import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uno_project/api/jogador.dart';
import 'package:uno_project/api/jogo.dart';
import 'api/jogador.dart';
import 'api/jogo.dart';
import 'screen/Inicial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JogadorController>(
          create: (context) => JogadorController(),
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
