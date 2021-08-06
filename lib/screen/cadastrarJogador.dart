import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/jogador.dart';
import '../api/jogador.dart';

import 'package:provider/provider.dart';

class CadastrarJogador extends StatefulWidget {
  @override
  _CadastrarJogadorState createState() => _CadastrarJogadorState();
}

class _CadastrarJogadorState extends State<CadastrarJogador> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _imagemController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _senhaSegundaController = TextEditingController();

  void limparCampos() {
    _nomeController.clear();
    _imagemController.clear();
    _emailController.clear();
    _senhaController.clear();
    _senhaSegundaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JogadorController>(
      builder: (_, jogadorController, __) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Novo Jogador"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: jogadorController.loading
                ? null
                : () async {
                    Jogador j = Jogador(
                      nome: _nomeController.text,
                      contato: _imagemController.text,
                      email: _emailController.text,
                      senha: _senhaController.text,
                      id: "",
                    );
                    if (formKey.currentState!.validate()) {
                      if (_senhaController.text ==
                          _senhaSegundaController.text) {
                        await jogadorController.criar(
                            jogador: j,
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
                      } else {
                        scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content: Text(
                            "Senhas diferentes",
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 3),
                        ));
                      }
                    }
                  },
            tooltip: 'Salvar Musica',
            backgroundColor:
                jogadorController.loading ? Colors.grey : Colors.blue,
            elevation: jogadorController.loading ? 0 : 3,
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
                          controller: _nomeController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
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
                          controller: _imagemController,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
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
                          controller: _emailController,
                          keyboardType: TextInputType.text,
                          validator: (email) {
                            if (email!.isEmpty) return 'Campo obrigatório';
                            return null;
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
                        TextFormField(
                          controller: _senhaController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            labelText: "Senha",
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: _senhaSegundaController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text) {
                            if (text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            labelText: "Repita a senha",
                          ),
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
