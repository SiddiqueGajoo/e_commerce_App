import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/view/HomeScreen.dart';
import 'package:e_commerce_app/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenDrawer extends StatelessWidget {
  const OpenDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
            ),
            child: Text(
              'Welcome, User',
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              // Navigate to Home
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            subtitle: Text('value'),
            onTap: ()async {
              final cartProvider = Provider.of<CartProvider>(context, listen: false);
              cartProvider.isLogin = false;
              cartProvider.setPrefsItems();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
