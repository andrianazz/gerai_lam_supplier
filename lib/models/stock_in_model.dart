class StockInModel {
  int? id;
  int? harga;
  int? hargaJual;
  String? kode;
  String? nama;
  int? stok;
  int? total;

  StockInModel({
    this.id,
    this.harga,
    this.hargaJual,
    this.kode,
    this.nama,
    this.stok,
    this.total,
  });

  StockInModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    harga = int.parse(json['harga'].toString());
    hargaJual = int.parse(json['harga_jual'].toString());
    kode = json['kode'];
    nama = json['nama'];
    stok = int.parse(json['stok'].toString());
    total = int.parse(json['total'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'harga': harga,
      'harga_jual': hargaJual,
      'kode': kode,
      'nama': nama,
      'stok': stok,
      'total': total,
    };
  }
}

List<StockInModel> mockStockIn = [
  StockInModel(
    harga: 2000,
    kode: 'WS-001',
    nama: 'Wortel Segar',
    stok: 1,
    total: 2000,
  ),
];
