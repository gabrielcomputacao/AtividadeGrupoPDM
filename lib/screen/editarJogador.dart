import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/jogador.dart';
import '../api/jogador.dart';

class EditarJogador extends StatefulWidget {
  final Jogador jogador;
  EditarJogador({required this.jogador});

  @override
  _EditarJogadorState createState() => _EditarJogadorState();
}

class _EditarJogadorState extends State<EditarJogador> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _imagemController = TextEditingController();
  final _emailController = TextEditingController();

  void limparCampos() {
    _nomeController.clear();
    _imagemController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JogadorController>(
      builder: (_, jogadorController, __) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Editar Jogador"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: jogadorController.loading
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      await jogadorController.atualizar(
                          jogador: Jogador(
                            nome: _nomeController.text.isNotEmpty
                                ? _nomeController.text
                                : widget.jogador.nome,
                            contato: _imagemController.text.isNotEmpty
                                ? (_imagemController.text)
                                : widget.jogador.contato,
                            email: _emailController.text.isNotEmpty
                                ? _emailController.text
                                : widget.jogador.email,
                            senha: "",
                            id: widget.jogador.id,
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
            tooltip: 'Editar musica',
            backgroundColor:
                jogadorController.loading ? Colors.grey : Colors.blue,
            elevation: jogadorController.loading ? 0 : 3,
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (jogadorController.loading)
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
                          initialValue: widget.jogador.nome,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            _nomeController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            labelText: "Nome do Jogador",
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          initialValue: widget.jogador.contato,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            _imagemController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            labelText: "Foto",
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          initialValue: widget.jogador.email,
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            _emailController.text = text;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            labelText: "E-mail",
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
