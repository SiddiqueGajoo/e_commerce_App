import 'package:flutter/material.dart';
class CartModel{
  final String? url, title, size;
  final double ? price;
  int color,id;
  CartModel({
required this.url,
    required this.title,required this.size,required this.price,required this.color,required this.id
});
  CartModel.fromMap(Map<dynamic,dynamic>res)
  : url = res['url'],
  title = res['title'],
  size = res['size'],
  price = res['price'],
  id = res['id'],
  color = res['color'];
  Map<String,Object?>toMap(){
    return {
      'url':url,
      'title':title,
      'size':size,
      'price':price,
      'color':color,
      'id':id,
    };
  }
}