import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlite_v1/controllers/product_controller.dart';
import 'package:sqlite_v1/models/product_model.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController productNameCrtl = TextEditingController();
  TextEditingController productDescCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  ProductController productController = Get.put(ProductController());

  bool hasPickedImage = false;
  File? _image;
  String? _base64, _parsedDate;
  final picker = ImagePicker();

  addProductItem() {
    productController.insertProduct(
      ProductModel(
        name: productNameCrtl.text,
        desc: productDescCtrl.text,
        price: productPriceCtrl.text,
        isFavorite: 0,
        photo: _base64,
      ),
    );
  }

  _getImageFromDevice(String mode) async {
    final pickedFile = await picker.getImage(
        source: mode == "library" ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 980,
        maxWidth: 735);

    if (pickedFile != null) {
      setState(() {
        var pathFile = pickedFile.path;
        File imageFile = File(pathFile);

        _base64 = base64.encode(imageFile.readAsBytesSync());
        _image = imageFile;
      });
    }
  }

  void showImagePicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
            child: Container(
          child: new Wrap(
            children: [
              new ListTile(
                leading: new Icon(Icons.photo_library, color: Colors.blue),
                title: new Text('Library'),
                onTap: () {
                  // _imgFromGallery();
                  _getImageFromDevice("library");
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.photo_camera, color: Colors.blue),
                title: new Text('Camera'),
                onTap: () {
                  // _imgFromCamera();
                  _getImageFromDevice("camera");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Product"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: [
                  Text('Product Name'),
                  TextFormField(
                    controller: productNameCrtl,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: [
                  Text('Product Description'),
                  TextFormField(
                    controller: productDescCtrl,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: [
                  Text('Product Price'),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: productPriceCtrl,
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                showImagePicker(context);
              },
              child: Text('Pilih Foto'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addProductItem();

          setState(() {});
          Navigator.pop(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
