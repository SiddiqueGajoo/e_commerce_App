// user_provider.dart
import 'dart:convert';
import 'package:e_commerce_app/model/users_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  List<usersModel> _users = [];
  bool _isLoaded = false;

  List<usersModel> get users => _users;
  bool get isLoaded => _isLoaded;

  Future<void> fetchUsers() async {
    if (_isLoaded) return; // don't load again if already loaded

    final response = await http.get(Uri.parse('https://fakestoreapi.com/users'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _users = data.map<usersModel>((item) => usersModel.fromJson(item)).toList();
      _isLoaded = true;
      notifyListeners();
    } else {
      throw Exception("Failed to fetch users");
    }
  }

  usersModel? login(String phone, String password) {
    return _users.firstWhere(
          (user) => user.phone.toString() == phone && user.password == password,
    );
  }
}
