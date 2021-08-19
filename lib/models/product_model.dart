// properti
// id produk, nama produk, penjual, harga, stok, deskripsi, wishlist, lokasi
//

final String productTable = 'product';
final String columnId = '_id';
final String columnProductName = 'product_name';
final String columnProductDesc = 'product_desc';
final String columnProductPrice = 'product_price';
final String columnProductFavorites = 'product_favorite';
final String columnProductPhoto = 'product_photo';

class ProductModel {
  int? id;
  String? name;
  String? desc;
  String? price;
  int? isFavorite;
  String? photo;

  ProductModel({
    this.id,
    this.name,
    this.desc,
    this.price,
    this.isFavorite,
    this.photo, // base64 code from image
  });

  // fungsi toMap digunakan untuk mengubah data dari kelas dart ke objek map => objek map digunakan sebagai format insert data ke db
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnProductName: name,
      columnProductDesc: desc,
      columnProductPrice: price,
      columnProductFavorites: isFavorite,
      columnProductPhoto: photo,
    };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }

  // fungsi fromMap digunakan untuk konversi objek hasil query db, ke objek model dart
  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      id: map[columnId],
      name: map[columnProductName],
      desc: map[columnProductDesc],
      price: map[columnProductPrice],
      isFavorite: map[columnProductFavorites],
      photo: map[columnProductPhoto],
    );
  }
}
