import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/jogador.dart';
import '../api/jogo.dart';
import '../component/cardJogo.dart';
import '../screen/cadastrarJogo.dart';

class Jogos extends StatelessWidget {
  final Jogador jogador;
  Jogos({required this.jogador});

  @override
  Widget build(BuildContext context) {
    return Consumer<JogoController>(
      builder: (_, jogoController, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Jogos",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarJogo(
                    jogador: jogador,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: jogoController.jogos.length,
            itemBuilder: (context, index) {
              return CardJogo(
                jogo: jogoController.jogos[index],
                jogador: jogador,
              );
            },
          ),
        );
      },
    );
  }
}
