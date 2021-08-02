class Predio{
  String clave_cat;
  String predialant;
  String tipo_predio;
  String propiedad;
  String calle;
  String calle_s;
  String nombre_urb;
  String numero_vivienda;
  String area_solar;
  String area_declarada_const;
  String avaluo_solar;
  String avaluo_construccion;
  String avaluo_obra_complement;
  String avaluo_municipal;
  String num_lote;
  String num_manzana;
  String ficha_madre;
  String propiedad_horizontal;
  String alicuota_terreno;
  String ced_ruc_propietario;
  String nombre_propietario;

  Predio(
    clave_cat,
    predialant,
    tipo_predio,
    propiedad,
    calle,
    calle_s,
    nombre_urb,
    numero_vivienda,
    area_solar,
    area_declarada_const,
    avaluo_solar,
    avaluo_construccion,
    avaluo_obra_complement,
    avaluo_municipal,
    num_lote,
    num_manzana,
    ficha_madre,
    propiedad_horizontal,
    alicuota_terreno,
    ced_ruc_propietario,
    nombre_propietario
  ){
    this.clave_cat = clave_cat;
    this.predialant = predialant;
    this.tipo_predio = tipo_predio;
    this.propiedad = propiedad;
    this.calle = calle;
    this.calle_s= calle_s;
    this.nombre_urb = nombre_urb;
    this.numero_vivienda = numero_vivienda;
    this.area_solar = area_solar;
    this.area_declarada_const = area_declarada_const;
    this.avaluo_solar = avaluo_solar;
    this.avaluo_construccion = avaluo_construccion;
    this.avaluo_obra_complement = avaluo_obra_complement;
    this.avaluo_municipal= avaluo_municipal;
    this.num_lote = num_lote;
    this.num_manzana = num_manzana;
    this.ficha_madre = ficha_madre;
    this.propiedad_horizontal = propiedad_horizontal;
    this.alicuota_terreno = alicuota_terreno;
    this.ced_ruc_propietario = ced_ruc_propietario;
    this.nombre_propietario = nombre_propietario;
  }
}