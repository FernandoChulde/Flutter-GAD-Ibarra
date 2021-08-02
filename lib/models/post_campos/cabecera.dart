import "dart:convert";

class Cabecera {
  String fii_id_ficha;
  String fii_comentario;
  String fii_observaciones;
  String fii_usuario;

  Cabecera(
      {this.fii_id_ficha,
      this.fii_comentario,
      this.fii_observaciones,
      this.fii_usuario});

  factory Cabecera.fromJson(Map json) {
    return Cabecera(
        fii_id_ficha: json['fii_id_ficha'],
        fii_comentario: json['fii_comentario'],
        fii_observaciones: json['fii_observaciones'],
        fii_usuario: json['fii_usuario']);
  }

  // List<Cabecera> cabeceraFromJson(String jsonData) {
  //   final data = json.decode(jsonData);
  //   return List<Cabecera>.from(data.map((item) => Cabecera.fromJson(item)));
  // }

  Map toJason() {
    var map = new Map(); 
      map["fii_id_ficha"] = fii_id_ficha;
      map["fii_comentario"] = fii_comentario;
      map["fii_observaciones"] = fii_observaciones;
      map["fii_usuario"]= fii_usuario;
    
    return map;
  }
}
