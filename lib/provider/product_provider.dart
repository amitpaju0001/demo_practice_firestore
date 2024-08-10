import 'package:demo_practice_firestore/model/product_model.dart';
import 'package:demo_practice_firestore/service/product_firebase_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider(this.productFirebaseService);

  final ProductFirebaseService productFirebaseService;
  List<ProductModel> _product = [];

  List<ProductModel> get product => _product;

  Future<void> addProduct(ProductModel productModel) async {
    await productFirebaseService.addProduct(productModel);
    await fetchProduct();
    print('product added');
  }

  Future<void> fetchProduct() async {
    _product = await productFirebaseService.getProduct();
    print('product fetched successfully');
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    await productFirebaseService.deleteProduct(id);
    await fetchProduct();
    print('product deleted');
  }

  Future<void> updateProduct(ProductModel productModel) async {
    await productFirebaseService.updateProduct(productModel);
    await fetchProduct();
    print('product updated');
  }
}
