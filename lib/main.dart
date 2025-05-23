import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:e_commerce_app/view/login_screen.dart';
import 'package:e_commerce_app/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> CartProvider()),
      ChangeNotifierProvider(create: (_)=> ProductProvider()),
      ChangeNotifierProvider(create: (_)=> UserProvider()),
    ],
    child: Builder(builder: (BuildContext context){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          primaryColor: Colors.orange,
          primaryColorLight: Colors.white,
          primaryColorDark: Colors.black,
          secondaryHeaderColor: Color(0xff808080),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home:SplashScreen()
      );
    }),);
  }
}

