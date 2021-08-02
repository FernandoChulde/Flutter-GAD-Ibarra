import "dart:convert";

class Detalle{
  String id_ficha_info;
  String id_campo;
  String valor;

  Detalle(
      {this.id_ficha_info,
      this.id_campo,
      this.valor});

  factory Detalle.fromJson(Map json) {
    return Detalle(
        id_ficha_info: json['id_ficha_info'],
        id_campo: json['id_campo'],
        valor: json['valor']);
  }

  Map toJason() {
    var map = new Map();
      map["id_ficha_info"] = id_ficha_info;
      map["id_campo"] = id_campo;
      map["valor"] = valor;
    return map;
  }
}