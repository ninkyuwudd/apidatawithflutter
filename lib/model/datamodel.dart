class Datamodel{
  int? id;
  String? namapesawat;
  String? asal;
  String? tujuan;
  String? kelas;
  DateTime? tanggalberangkat;
  DateTime? tanggalpulang;
  int? harga;

  Datamodel({
    this.id ,
    this.namapesawat,
    this.asal,
    this.tujuan,
    this.kelas,
    this.tanggalberangkat,
    this.tanggalpulang,
    this.harga
  });

  Datamodel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    namapesawat = json['namapesawat'];
    asal = json['asal'];
    tujuan = json['tujuan'];
    kelas = json['kelas'];
    tanggalberangkat = json['tanggalberangkat'];
    tanggalpulang = json['tanggalpulang'];
    harga = json['harga'];
  }
}