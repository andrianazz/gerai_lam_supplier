class StockReturnModel {
  int? id;
  int? harga;
  int? hargaJual;
  String? kode;
  String? nama;
  int? stok;
  int? total;

  StockReturnModel({
    this.id,
    this.harga,
    this.hargaJual,
    this.kode,
    this.nama,
    this.stok,
    this.total,
  });

  StockReturnModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    harga = int.parse(json['harga']);
    hargaJual = int.parse(json['harga_jual']);
    kode = json['kode'];
    nama = json['nama'];
    stok = int.parse(json['stok']);
    total = int.parse(json['total']);
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

List<StockReturnModel> mockStockIn = [
  StockReturnModel(
    harga: 2000,
    kode: 'WS-001',
    nama: 'Wortel Segar',
    stok: 1,
    total: 2000,
  ),
];
