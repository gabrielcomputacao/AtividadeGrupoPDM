import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'api.dart';
import '../model/jogo.dart';

class JogoController extends ChangeNotifier {
  List<Jogo> jogos = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> listar({required String? jogadorId}) async {
    loading = true;
    jogos.clear();
    try {
      var url = Uri.https(api_url, '/jogadores/$jogadorId/jogos.json');

      var response = await http.get(url);

      if (response.body != 'null') {
        Map<String, dynamic> data =
            new Map<String, dynamic>.from(json.decode(response.body));

        data.forEach((key, value) {
          jogos.add(Jogo.fromJson(value, key));
        });
      }

      loading = false;
    } catch (error) {
      jogos.clear();
      throw error;
    }
  }

  Future<void> criar({
    required String? jogadorId,
    required Jogo jogo,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    loading = true;

    var body = json.encode({
      'data': jogo.data,
      'jogadores': jogo.jogadores,
      'posicao': jogo.posicao,
    });

    var url = Uri.https(api_url, '/jogadores/$jogadorId/jogos.json');

    await http.post(url, body: body);

    await listar(jogadorId: jogadorId);

    onSuccess("Jogo cadastrado com sucesso!");
  }

  Future<void> atualizar({
    required String? jogadorId,
    required Jogo jogo,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    loading = true;

    var body = json.encode({
      'data': jogo.data,
      'jogadores': jogo.jogadores,
      'posicao': jogo.posicao,
    });

    var url = Uri.https(api_url, "/jogadores/$jogadorId/jogos/${jogo.id}.json");

    await http.put(url, body: body);

    await listar(jogadorId: jogadorId);

    onSuccess("Jogo editada com sucesso!");
  }

  Future<void> deletar(String? jogadorId, String? jogoId) async {
    loading = true;

    var url = Uri.https(api_url, "/jogadores/$jogadorId/jogos/$jogoId.json");

    await http.delete(url);

    await listar(jogadorId: jogadorId);
  }
}
