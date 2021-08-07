import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/jogador.dart';
import '../model/jogo.dart';
import '../api/jogo.dart';

import '../screen/editarJogo.dart';

class CardJogo extends StatelessWidget {
  final Jogador jogador;
  final Jogo jogo;
  CardJogo({required this.jogador, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return Consumer<JogoController>(
      builder: (_, jogoController, __) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 3,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ("Data: " + jogo.data),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    ("Numero de jogadores: " + jogo.jogadores),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    ("Posição: " + jogo.posicao),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditarJogo(
                                jogador: jogador,
                                jogo: jogo,
                              ),
                            ),
                          );
                        },
                        tooltip: "Editar",
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: jogoController.loading
                            ? null
                            : () async {
                                await jogoController.deletar(
                                    jogador.id, jogo.id);
                              },
                        tooltip: "Deletar",
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
