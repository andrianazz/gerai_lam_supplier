class StockInModel {
  int? id;
  int? harga;
  String? kode;
  String? nama;
  int? stok;
  int? total;

  StockInModel({
    this.id,
    this.harga,
    this.kode,
    this.nama,
    this.stok,
    this.total,
  });

  StockInModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    harga = json['harga'];
    kode = json['kode'];
    nama = json['nama'];
    stok = json['stok'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'harga': harga,
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
