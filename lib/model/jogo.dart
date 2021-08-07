class Jogo {
  String id = "";
  String jogadores = "";
  String posicao = "";
  String data = "";

  Jogo({
    required this.id,
    required this.jogadores,
    required this.posicao,
    required this.data,
  });

  Jogo.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    jogadores = json["jogadores"].toString();
    posicao = json["posicao"].toString();
    data = json["data"];
  }
}
