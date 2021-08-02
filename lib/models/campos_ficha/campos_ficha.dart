class CamposFicha{
  String fic_id;
  String fic_id_ficha;
  String fic_nombre;
  String fic_descripcion;
  String fic_tipo;
  String fic_tipo_opcion;
  String fic_orden;
  
  CamposFicha(
    fic_id,
    fic_id_ficha,
    fic_nombre,
    fic_descripcion,
    fic_tipo,
    fic_tipo_opcion,
    fic_orden
  ){
    this.fic_id = fic_id;
    this.fic_id_ficha = fic_id_ficha;
    this.fic_nombre = fic_nombre;
    this.fic_descripcion = fic_descripcion;
    this.fic_tipo = fic_tipo;
    this.fic_tipo_opcion = fic_tipo_opcion;
    this.fic_orden = fic_orden;
  }
}