class ProductModel {
  String? id;
  String? nama;
  String? kode;
  int? harga_jual;
  int? harga_modal;
  String? deskripsi;
  List<String>? imageUrl;
  int? stok;
  int? stok_awal;
  DateTime? stok_tanggal;
  List<dynamic>? tag;
  Map<String, dynamic>? supplier;

  ProductModel({
    this.id,
    this.nama,
    this.kode,
    this.harga_jual,
    this.harga_modal,
    this.deskripsi,
    this.imageUrl,
    this.stok,
    this.stok_awal,
    this.stok_tanggal,
    this.tag,
    this.supplier,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    kode = json['kode'];
    harga_jual = int.parse(json['harga_jual'].toString());
    harga_modal = int.parse(json['harga_modal'].toString());
    deskripsi = json['deskripsi'];
    imageUrl = json['imageUrl'].map<String>((e) => e.toString()).toList();
    stok = json['sisa_stok'];
    stok_awal = json['stok_awal'];
    stok_tanggal = json['stok_tanggal'].toDate();
    tag = json['tag'];
    supplier = json['supplier'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kode': kode,
      'harga_jual': harga_jual,
      'harga_modal': harga_modal,
      'deskripsi': deskripsi,
      'imageUrl': imageUrl!.map((e) => e).toList(),
      'sisa_stok': stok,
      'stok_awal': stok_awal,
      'stok_tanggal': stok_tanggal.toString(),
      'tag': tag,
      'supplier': supplier,
    };
  }
}
