import 'category_model.dart';

class ProductModel {
  String? name;
  int? price;
  String? description;
  String? imageUrl;
  int? stok;
  CategoryModel? categoryModel;
  DateTime? createdAt;

  ProductModel({
    this.name,
    this.price,
    this.description,
    this.imageUrl,
    this.stok,
    this.categoryModel,
    this.createdAt,
  });
}

List<ProductModel> mockProduct = [
  ProductModel(
    name: 'Wortel Segar',
    price: 14000,
    description:
        'Wortel merupakan sayuran berwarna oranye yang banyak digemari, karena rasanya yang enak dan manfaat wortel yang melimpah. Wortel bisa dimakan mentah, direbus, atau digoreng, dibuat jus, atau campuran puding.',
    imageUrl:
        'https://ik.imagekit.io/10tn5i0v1n/article/f7868cd4c1339025ba7656df2175e9d4.jpeg',
    stok: 100,
    categoryModel: mockCategory[0],
    createdAt: DateTime.now(),
  ),
  ProductModel(
    name: 'Cabe Segar',
    price: 35000,
    description:
        'Cabai adalah buah dan tumbuhan anggota genus Capsicum. Buahnya dapat digolongkan sebagai sayuran maupun bumbu, tergantung bagaimana pemanfaatannya. Sebagai bumbu, buah cabai yang pedas sangat populer di Asia Tenggara sebagai penguat rasa makanan.',
    categoryModel: mockCategory[0],
    imageUrl: 'https://kbu-cdn.com/bc/wp-content/uploads/cabe-cabai.jpg',
    stok: 40,
    createdAt: DateTime.now(),
  ),
  ProductModel(
    name: 'Beras Belida Edisi Spesial',
    price: 50000,
    description:
        'Beras adalah bagian bulir padi (gabah) yang telah dipisah dari sekam. Sekam (Jawa merang) secara anatomi disebut palea (bagian yang ditutupi) dan lemma (bagian yang menutupi).',
    categoryModel: mockCategory[1],
    imageUrl:
        'https://media.suara.com/pictures/653x366/2014/10/24/o_1950dm43f1fr910u51bme1jkk9ibq.jpg',
    stok: 80,
    createdAt: DateTime.now(),
  ),
  ProductModel(
    name: 'Roti Lapis',
    price: 4000,
    description:
        'BRoti lapis atau roti isi (bahasa Inggris: sandwich), adalah makanan yang biasanya terdiri dari sayuran, keju atau daging yang diiris',
    categoryModel: mockCategory[2],
    imageUrl:
        'https://statik.tempo.co/data/2019/10/06/id_878322/878322_720.jpg',
    stok: 45,
    createdAt: DateTime.now(),
  ),
  ProductModel(
    name: 'Shampoo Unilever',
    price: 4000,
    description:
        'Sampo (bahasa Inggris: shampoo) adalah sejenis cairan, seperti sabun, yang berfungsi untuk meningkatkan tegangan permukaan kulit (umumnya kulit kepala) sehingga dapat meluruhkan kotoran (membersihkan).',
    categoryModel: mockCategory[3],
    imageUrl:
        'https://www.paulaschoice-eu.com/on/demandware.static/-/Sites-paulaschoice-catalog/default/dw4fa91958/images/5000-lifestyle.jpg',
    stok: 55,
    createdAt: DateTime.now(),
  ),
];
