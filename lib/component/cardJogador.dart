import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/jogador.dart';
import '../api/jogo.dart';
import '../model/jogador.dart';
import '../screen/editarJogador.dart';
import '../screen/jogos.dart';

class CardJogador extends StatelessWidget {
  final Jogador jogador;
  CardJogador({required this.jogador});

  @override
  Widget build(BuildContext context) {
    return Consumer2<JogadorController, JogoController>(
      builder: (_, jogadorController, jogoController, __) {
        return GestureDetector(
          onTap: () {
            jogoController.listar(jogadorId: jogador.id);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Jogos(
                  jogador: jogador,
                ),
              ),
            );
          },
          child: Card(
            elevation: 3,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            jogador.nome,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            jogador.contato,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            jogador.email,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: jogadorController.loading
                                    ? null
                                    : () async {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditarJogador(jogador: jogador),
                                          ),
                                        );
                                      },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: jogadorController.loading
                                    ? null
                                    : () async {
                                        await jogadorController
                                            .deletar(jogador.id);
                                      },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
