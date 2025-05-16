import 'package:e_commerce_app/Database/db_helper.dart';
import 'package:e_commerce_app/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  DBHelper? db = DBHelper();

  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<CartModel>> _cart;
  Future<List<CartModel>> get cart => _cart;

  CartProvider() {
    getPrefsItems();
    getData();
  }

  Future<List<CartModel>> getData() async {
    _cart = db!.getCartList();
    return _cart;
  }



  void setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  // Cart operations
  void addTotalPrice(double productPrice) {
    _totalPrice += productPrice;
    setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice -= productPrice;
    setPrefsItems();
    notifyListeners();
  }

  double getTotalPrice() {
    getPrefsItems();
    return _totalPrice;
  }

  int getCounter() {
    getPrefsItems();
    return _counter;
  }

  void addCounter() {
    _counter++;
    setPrefsItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    setPrefsItems();
    notifyListeners();
  }
}
