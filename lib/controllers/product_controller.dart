import 'package:get/get.dart';
import 'package:sqlite_v1/models/product_model.dart';
import 'package:sqlite_v1/utils/dbhelper.dart';

class ProductController extends GetxController {
  ProductProvider productProvider = ProductProvider();
  var listProducts = <ProductModel>[].obs;

  Map<String, dynamic> modelTestToMap() {
    ProductModel product = ProductModel(
      id: 1,
      name: 'Sepatuv1',
      desc: 'Sepatu Olahraga',
      price: 'Rp150.000',
    );

    Map<String, dynamic> map = product.toMap();
    return map;
  }

  modelTestFromMap(Map<String, dynamic> map) {
    var product = ProductModel.fromMap(map);

    print('product from map: $product');
    print(product.id);
    print(product.name);
    print(product.desc);
    print(product.price);
  }

  insertProduct(ProductModel product) async {
    await productProvider.insertProduct(product);
  }

  getAllProducts() async {
    listProducts.clear();
    var queryResults = await productProvider.getAllProducts();

    queryResults.forEach((element) {
      listProducts.add(element);
    });
  }

  Future<ProductModel> getDetailProduct(int? id) async {
    return await productProvider.getDetailProduct(id);
  }

  removeProduct(int id) async {
    await productProvider.removeProduct(id);
  }

  Future<int> updateProduct(ProductModel updatedItem) async {
    return await productProvider.updateProduct(updatedItem);
  }
}
