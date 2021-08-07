import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/jogador.dart';
import '../screen/cadastrarJogador.dart';
import '../component/cardJogador.dart';

class Inicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JogadorController>(
      builder: (_, jogadorController, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Jogadores",
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
                  builder: (context) => CadastrarJogador(),
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
            padding: EdgeInsets.all(20),
            itemCount: jogadorController.jogadores.length,
            itemBuilder: (context, index) {
              return CardJogador(
                jogador: jogadorController.jogadores[index],
              );
            },
          ),
        );
      },
    );
  }
}
