import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_v1/controllers/product_controller.dart';
import 'package:sqlite_v1/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productModel;
  ProductCard({required this.productModel});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ProductController productController = Get.find();
  var favs = 0.obs;

  Uint8List decodeImage(String _base64) {
    Uint8List bytes = base64.decode(_base64);
    return bytes;
  }

  Future<ProductModel> getDataProductByID() async {
    int? id = this.widget.productModel.id;
    var result = await productController.getDetailProduct(id);

    print('After Update item: ');
    print(result.name);
    print(result.desc);
    print(result.isFavorite);
    print(result.price);
    print(result.photo);

    print('result: ${result.isFavorite}');
    if (result.isFavorite == 1)
      favs.value = 1;
    else
      favs.value = 0;

    print('favs: ${favs.value}');

    return result;
  }

  updateFavoriteStatus() async {
    ProductModel productModel = new ProductModel();
    productModel.name = this.widget.productModel.name;
    productModel.desc = this.widget.productModel.desc;
    productModel.price = this.widget.productModel.price;
    productModel.isFavorite = favs.value == 0 ? 1 : 0;
    productModel.photo = this.widget.productModel.photo;

    var result = await productController.updateProduct(productModel);
    if (result >= 0) setState(() {});

    getDataProductByID();
  }

  @override
  void initState() {
    if (this.widget.productModel.isFavorite == 0)
      favs.value = 0;
    else
      favs.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 35,
          backgroundImage: MemoryImage(
            decodeImage('${this.widget.productModel.photo}'),
          ),
        ),
        title: Text(
          '${this.widget.productModel.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          '${this.widget.productModel.desc} | Rp ${this.widget.productModel.price}',
        ),
        trailing: Obx(
          () => GestureDetector(
            onTap: () {
              print('Fav!');
              updateFavoriteStatus();
            },
            child: Icon(
              favs.value == 0 ? Icons.favorite_border : Icons.favorite,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
