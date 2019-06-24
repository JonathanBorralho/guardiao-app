class Parceria{
  final String idParceria;
  final String idRamoAtividade;
  final String ramoAtividade;
  final String idSuperRamoAtividade;
  final String superRamoAtividade;
  final String nomeParceria;
  final String descricaoRamoAtividade;
  final String descontos;
  final String endereco;
  final String bairro;
  final String tempoDuracaoParceria;

  final String logomarcaUrl;
  final String tabelaInfoParceiroUrl;
  final String termoParceriaUrl;

  final String facebook;
  final String instagram;
  final String email;
  final String googleMaps;
  final String site;
  final String whatsapp;
  final String telefone1;
  final String telefone2;

  Parceria({this.idParceria, this.nomeParceria, this.idRamoAtividade, this.ramoAtividade, this.idSuperRamoAtividade, this.superRamoAtividade,
    this.descricaoRamoAtividade, this.descontos, this.endereco, this.bairro, this.tempoDuracaoParceria, this.logomarcaUrl,
    this.tabelaInfoParceiroUrl, this.termoParceriaUrl, this.facebook, this.instagram, this.email, this.googleMaps, this.site,
    this.whatsapp, this.telefone1, this.telefone2});

  factory Parceria.fromJson(Map<String, dynamic> json) {
    return new Parceria(
        idParceria: json["idParceria"],
        idRamoAtividade: json["idRamoAtividade"],
        ramoAtividade: json["ramoAtividade"],
        idSuperRamoAtividade: json["idSuperRamoAtividade"],
        superRamoAtividade: json["superRamoAtividade"],
        nomeParceria: json["nomeParceria"],
        descricaoRamoAtividade: json["descricaoRamoAtividade"],
        descontos: json["descontos"],
        endereco: json["endereco"],
        bairro: json["bairro"],
        tempoDuracaoParceria: json["tempoDuracaoParceria"],

        logomarcaUrl: json["logomarcaUrl"],
        tabelaInfoParceiroUrl: json["tabelaInfoParceiroUrl"],
        termoParceriaUrl: json["termoParceriaUrl"],

        facebook: json["facebook"],
        instagram: json["instagram"],
        email: json["email"],
        googleMaps: json["googleMaps"],
        site: json["site"],
        whatsapp: json["whatsapp"],
        telefone1: json["telefone1"],
        telefone2: json["telefone2"]
    );
  }

  @override
  String toString() {
    return 'Parceria: $nomeParceria';
  }

  String retornaRamoAtividade() {
    String ramoAtividade = '';
    if (this.superRamoAtividade != '') {
      ramoAtividade = this.superRamoAtividade  + '\n' + this.ramoAtividade;
    } else {
      ramoAtividade = this.ramoAtividade + '';
    }
    return ramoAtividade;
  }
}