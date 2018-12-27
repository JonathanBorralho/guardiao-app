
class Sistema{
  final String id;
  final String categoriaSistema;
  final String sigla;
  final String nome;
  final String cor;
  final String observacao;
  final String iconeUrl;

  Sistema({this.id, this.categoriaSistema, this.sigla, this.nome, this.cor, this.observacao, this.iconeUrl});

  factory Sistema.fromJson(Map<String, dynamic> json) {
    return new Sistema(
        id: json["id"],
        categoriaSistema: json["categoriaSistema"],
        sigla: json["sigla"],
        nome: json["nome"],
        cor: json["cor"],
        observacao: json["observacao"],
        iconeUrl: json["iconeUrl"]
    );
  }

  @override
  String toString() {
    return '$nome';
  }

}