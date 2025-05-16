import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return FutureBuilder(
      future: productProvider.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && productProvider.products.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading products'));
        }
        return ListView.builder(
          itemCount: productProvider.products.length,
          itemBuilder: (context, index) {
            final product = productProvider.products[index];
            return ListTile(
              leading: Image(image: NetworkImage(product.image.toString())),
              title: Text(product.title ?? ''),
              subtitle: Text("\$${product.price.toString()}"),
            );
          },
        );
      },
    );
  }
}

//Home Page
// import 'dart:convert';
// import 'package:e_commerce_app/model/prodcutStore.dart';
// import 'package:e_commerce_app/view/details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//
//   String? selectedCategory = 'men\'s clothing';
//   Future<List<productStore>> getProductApi() async {
//     final response =
//     await http.get(Uri.parse('https://fakestoreapi.com/products'));
//     var data = jsonDecode(response.body.toString());
//     if (response.statusCode == 200) {
//       return (data as List)
//           .map((json) => productStore.fromJson(json))
//           .toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: FutureBuilder<List<productStore>>(
//         future: getProductApi(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No products available'));
//           } else {
//             final productsList = snapshot.data!;
//             final uniqueCategories = productsList
//                 .map((product) => product.category)
//                 .toSet()
//                 .toList();
//             return SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 18),
//                     Text(
//                       'Match Your Style',
//                       style: GoogleFonts.poppins(fontSize: 28),
//                     ),
//
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search',
//                         hintStyle: GoogleFonts.poppins(
//                             color: Colors.grey, fontSize: 16),
//                         prefixIcon: const Icon(Icons.search),
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//
//                     /// Categories Horizontal List
//                     const SizedBox(height: 16),
//                     SizedBox(
//                       height: 40,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: uniqueCategories.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             // Color(0xffE7E7E7)
//                               padding: const EdgeInsets.only(right: 12),
//                               child: TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     selectedCategory = uniqueCategories[index];
//                                   });
//                                 },
//                                 style: TextButton.styleFrom(
//                                   backgroundColor: selectedCategory == uniqueCategories[index]
//                                       ? Colors.orange // selected background
//                                       : Color(0xffE7E7E7), // default background
//                                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                                 ),
//                                 child: Text(
//                                   uniqueCategories[index].toString(),
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 14,
//                                     color: selectedCategory == uniqueCategories[index]
//                                         ? Colors.white // selected text
//                                         : Colors.orange, // default text
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               )
//
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Expanded(
//                       child: GridView.builder(
//                         gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 8,
//                           crossAxisSpacing: 8,
//                           childAspectRatio: 0.7,
//                         ),
//                         itemCount: productsList.length,
//                         itemBuilder: (context, index) {
//                           final product = productsList[index];
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(child: InkWell(
//                                   onTap: (){
//                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(
//                                         price: product.price, title: product.title, url: product.image)));
//                                   }
//                                   ,child: Container(
//                                     height: 10,
//                                     width: 180,
//                                     decoration: BoxDecoration(
//                                         image: DecorationImage(image: NetworkImage(product.image.toString()),fit: BoxFit.fill),
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: Colors.transparent
//                                     ),
//                                     child:
//                                     Padding(
//                                       padding: EdgeInsets.all(12),
//                                       child: Align(
//                                         alignment: Alignment.topRight
//                                         ,child: CircleAvatar(
//                                         child: Icon(Icons.favorite,color: Colors.red,),
//                                       ),
//                                       ),
//                                     )
//                                 ),
//                                 )),
//                                 Text(product.title.toString(),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1
//                                   ,style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold
//                                   ),),
//                                 Text('\$'+product.price.toString(),style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                 ),),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
