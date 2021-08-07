import 'package:aulaconceitos/providers/login.dart';
import 'package:aulaconceitos/utils/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ModoAutenticacao { Cadastro, Login }

class CardLogin extends StatefulWidget {
  @override
  _CardLoginState createState() => _CardLoginState();
}

class _CardLoginState extends State<CardLogin> {
  final controladorSenha = TextEditingController();
  ModoAutenticacao modoAutenticacao = ModoAutenticacao.Login;
  bool loading = false;

  final form = GlobalKey<FormState>();

  final Map<String, String> dadosAutenticacao = {
    'email': '',
    'senha': '',
  };

  void showError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("erro"),
      ),
    );
  }

  Future<void> submit() async {
    if (!form.currentState.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    form.currentState.save();

    Login login = Provider.of(context, listen: false);

    if (modoAutenticacao == ModoAutenticacao.Login) {
      try {
        await login.realizarLogin(
          dadosAutenticacao['email'],
          dadosAutenticacao['senha'],
        );
        Navigator.of(context).pushReplacementNamed(Inicial());
      } catch (e) {
        showError();
      }
    } else {
      await login.registrar(
        dadosAutenticacao['email'],
        dadosAutenticacao['senha'],
      );
    }

    setState(() {
      loading = false;
    });
  }

  void trocaModo() {
    modoAutenticacao == ModoAutenticacao.Login
        ? setState(() {
            modoAutenticacao = ModoAutenticacao.Cadastro;
          })
        : setState(() {
            modoAutenticacao = ModoAutenticacao.Login;
          });
  }

  @override
  Widget build(BuildContext context) {
    final dimensoesDispositivo = MediaQuery.of(context).size;
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: dimensoesDispositivo.width * 0.75,
        height: modoAutenticacao == ModoAutenticacao.Login ? 320 : 300,
        child: Form(
          key: form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "E-email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'informe';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'informe';
                  }
                },
              ),
              SizedBox(height: 20),
              if (loading)
                CircularProgressIndicator()
              else
                TextButton(
                    onPressed: () {
                      submit();
                    },
                    child: Text(modoAutenticacao == ModoAutenticacao.Login
                        ? "Entrar"
                        : "Registrar")),
              TextButton(
                  onPressed: trocaModo,
                  child: Text(modoAutenticacao == ModoAutenticacao.Login
                      ? "Cadastrar"
                      : "Login"))
            ],
          ),
        ),
      ),
    );
  }
}