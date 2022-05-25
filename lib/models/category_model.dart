class CategoryModel {
  int? id;
  String? name;
  String? imageUrl;

  CategoryModel({
    this.id,
    this.name,
    this.imageUrl,
  });
}

List<CategoryModel> mockCategory = [
  CategoryModel(id: 1, name: 'Buah', imageUrl: 'assets/buah.png'),
  CategoryModel(id: 2, name: 'Sembako', imageUrl: 'assets/sembako.png'),
  CategoryModel(id: 3, name: 'Roti', imageUrl: 'assets/roti.png'),
  CategoryModel(id: 4, name: 'HealthCare', imageUrl: 'assets/healthcare.png'),
  CategoryModel(id: 5, name: 'Makanan', imageUrl: 'assets/makanan.png'),
  CategoryModel(id: 6, name: 'Obat', imageUrl: 'assets/obat.png'),
  CategoryModel(id: 7, name: 'Minuman', imageUrl: 'assets/minuman.png'),
  CategoryModel(id: 8, name: 'Lainnya', imageUrl: 'assets/lainnya.png'),
];
