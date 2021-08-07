import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/jogador.dart';
import '../model/jogo.dart';
import '../api/jogo.dart';

class EditarJogo extends StatefulWidget {
  final Jogador jogador;
  final Jogo jogo;
  EditarJogo({required this.jogador, required this.jogo});

  @override
  _EditarJogoState createState() => _EditarJogoState();
}

class _EditarJogoState extends State<EditarJogo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _dataController = TextEditingController();
  final _posicaoController = TextEditingController();
  final _jogadoresController = TextEditingController();

  void limparCampos() {
    _dataController.clear();
    _posicaoController.clear();
    _jogadoresController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JogoController>(
      builder: (_, jogoController, __) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Editar Jogo"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: jogoController.loading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      await jogoController.atualizar(
                          jogadorId: widget.jogador.id,
                          jogo: Jogo(
                            id: widget.jogo.id,
                            data: _dataController.text.isNotEmpty
                                ? _dataController.text
                                : widget.jogo.data,
                            jogadores: _jogadoresController.text.isNotEmpty
                                ? (_jogadoresController.text)
                                : widget.jogo.jogadores,
                            posicao: _posicaoController.text.isNotEmpty
                                ? (_posicaoController.text)
                                : widget.jogo.posicao,
                          ),
                          onSuccess: (text) async {
                            scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: Text(
                                text,
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.blue,
                              duration: Duration(seconds: 2),
                            ));

                            Future.delayed(Duration(seconds: 2)).then((_) {
                              Navigator.pop(context);
                            });
                          },
                          onFail: (text) {
                            scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: Text(
                                text,
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 3),
                            ));
                          });
                    }
                  },
            backgroundColor: jogoController.loading ? Colors.grey : Colors.blue,
            elevation: jogoController.loading ? 0 : 3,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (jogoController.loading)
                    LinearProgressIndicator(
                      color: Colors.blue,
                      backgroundColor: Colors.white,
                      minHeight: 5,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 36,
                        ),
                        TextFormField(
                          initialValue: widget.jogo.data,
                          keyboardType: TextInputType.datetime,
                          onChanged: (text) {
                            _dataController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            labelText: "Data",
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          initialValue: widget.jogo.jogadores,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            _jogadoresController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            labelText: "Numero de jogadores",
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          initialValue: widget.jogo.posicao,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            _posicaoController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            labelText: "Posição",
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
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
