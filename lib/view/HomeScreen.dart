import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/view/Home_Page.dart';
import 'package:e_commerce_app/view/ProductPage.dart';
import 'package:e_commerce_app/view/cart.dart';
import 'package:e_commerce_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
    Cart(),
    OpenDrawer()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       child: Column(
         children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             const Icon(Icons.menu),
             const CircleAvatar(
               backgroundImage: NetworkImage(
                   'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Lionel_Messi_31mar2007.jpg/330px-Lionel_Messi_31mar2007.jpg'),
             ),
           ],
                  ),
         ),
           Expanded(child: _screens[_currentIndex]),
         ],
       ),
     ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Badge(
                label: Consumer<CartProvider>(builder: (context,value,child){
                  return Text(value.getCounter().toString());
    }),
                child: Icon(Icons.shopping_cart),
              ),label: 'Cart',),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
