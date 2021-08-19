import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_v1/controllers/product_controller.dart';

class RemoveProductPage extends StatelessWidget {
  final ProductController productController = Get.find();

  TextEditingController numberCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Remove Product'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: numberCtrl,
              ),
              FlatButton(
                onPressed: () {
                  var value = int.parse(numberCtrl.text);
                  productController.removeProduct(value);

                  Navigator.pop(context);
                },
                child: Text('Remove'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
