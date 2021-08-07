import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/jogador.dart';
import '../model/jogo.dart';
import '../api/jogo.dart';

import 'package:provider/provider.dart';

class CadastrarJogo extends StatefulWidget {
  final Jogador jogador;
  CadastrarJogo({required this.jogador});

  @override
  _CadastrarJogotate createState() => _CadastrarJogotate();
}

class _CadastrarJogotate extends State<CadastrarJogo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _dataController = TextEditingController();
  final _jogadoresController = TextEditingController();
  final _posicaoController = TextEditingController();

  void limparCampos() {
    _dataController.clear();
    _jogadoresController.clear();
    _posicaoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JogoController>(
      builder: (_, jogoController, __) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Cadastrar Jogo"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: jogoController.loading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      await jogoController.criar(
                          jogadorId: widget.jogador.id,
                          jogo: Jogo(
                            id: "",
                            data: _dataController.text,
                            jogadores: _jogadoresController.text,
                            posicao: (_posicaoController.text),
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
            tooltip: 'Salvar Jogo',
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
                          controller: _dataController,
                          keyboardType: TextInputType.datetime,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: "Data",
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: _posicaoController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
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
                        TextFormField(
                          controller: _jogadoresController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: "Numero de jogadores",
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
