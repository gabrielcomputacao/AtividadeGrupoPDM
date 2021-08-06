import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'API.dart';
import '../model/jogador.dart';

class JogadorController extends ChangeNotifier {
  JogadorController() {
    listar();
  }

  List<Jogador> jogadores = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> listar() async {
    loading = true;
    jogadores.clear();
    try {
      var url = Uri.https(api_url, '/jogadores.json');

      var response = await http.get(url);

      if (response.body != 'null') {
        Map<String, dynamic> data =
            new Map<String, dynamic>.from(json.decode(response.body));

        print(response.body);

        data.forEach((key, value) {
          jogadores.add(Jogador.fromJson(value, key));
        });
      }
    } catch (error) {
      jogadores.clear();
    }
    loading = false;
  }

  Future<void> criar({
    required Jogador jogador,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    loading = true;

    var body = json.encode({
      'nome': jogador.nome,
      'email': jogador.email,
      'senha': jogador.senha,
      'contato': jogador.contato,
    });

    var url = Uri.https(api_url, '/jogadores.json');

    await http.post(url, body: body);

    await listar();

    onSuccess("Jogador cadastrado com sucesso!");
  }

  Future<void> atualizar({
    required Jogador jogador,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    loading = true;

    var body = json.encode({
      'nome': jogador.nome,
      'email': jogador.email,
      'senha': jogador.senha,
      'contato': jogador.contato,
    });

    var url = Uri.https(api_url, "/jogadores/${jogador.id}.json");

    await http.put(url, body: body);

    await listar();

    onSuccess("Jogador editado com sucesso!");
  }

  Future<void> deletar(String? jogadorId) async {
    loading = true;

    var url = Uri.https(api_url, "/jogadores/$jogadorId.json");

    await http.delete(url);

    await listar();
  }
}
