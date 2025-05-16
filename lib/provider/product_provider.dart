import 'package:e_commerce_app/model/prodcutStore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<productStore> _products = [];
  bool _isFetched = false;

  List<productStore> get products => _products;

  Future<void> fetchProducts() async {
    if (_isFetched) return;

    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _products = (data as List).map((json) => productStore.fromJson(json)).toList();
      _isFetched = true;
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }

  void clearProducts() {
    _products.clear();
    _isFetched = false;
    notifyListeners();
  }
}
