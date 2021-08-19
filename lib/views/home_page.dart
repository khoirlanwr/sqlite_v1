import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_v1/controllers/product_controller.dart';
import 'package:sqlite_v1/widgets/product_card_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController productController = Get.find();

  Map<String, dynamic> map = Map();

  Uint8List decodeImage(String _base64) {
    Uint8List bytes = base64.decode(_base64);
    return bytes;
  }

  @override
  void initState() {
    productController.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            FlatButton(
              onPressed: () {
                productController.getAllProducts();
                print('l: ${productController.listProducts.length}');
              },
              child: Text('Test get all products'),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: productController.listProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      productModel: productController.listProducts[index],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
