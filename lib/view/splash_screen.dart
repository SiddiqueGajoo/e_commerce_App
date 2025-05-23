import 'dart:async';

import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/view/HomeScreen.dart';
import 'package:e_commerce_app/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Ensures context is available after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginStatus();
    });
  }
  void checkLoginStatus() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.getPrefsItems(); // Load all shared prefs

    await Future.delayed(const Duration(seconds: 2)); // Optional splash delay

    if (cartProvider.isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  LoginScreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/logo.png')),
      ),
    );
  }
}
