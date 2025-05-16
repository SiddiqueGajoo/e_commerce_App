import 'package:e_commerce_app/Database/db_helper.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/widgets/orangeBtn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/model/cart_model.dart';
class DetailsScreen extends StatefulWidget {
  final String url, title;
  final double price;
  final id;

  DetailsScreen({
    required this.price,
    required this.title,
    required this.url,
    required this.id,
    super.key,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DBHelper dbHelper = DBHelper();
  Color? selectedColor;
  String? selectedSize;

  String shortenProductTitle(String title, {int maxWords = 3}) {
    final fillerWords = {
      'of', 'the', 'with', 'for', 'and', 'in', 'on', 'at', 'by', 'to', 'a', 'an', '&'
    };
    List<String> words = title
        .split(' ')
        .where((word) => !fillerWords.contains(word.toLowerCase()))
        .toList();
    return words.take(maxWords).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.url, height: height*.3, width: width*.9),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    shortenProductTitle(widget.title),
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${widget.price}',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Size',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: ['S', 'M', 'L', 'XL'].map((size) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: selectedSize == size ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(size),
                    ),
                  );
                }).toList(),
              ),
               SizedBox(height: height*.01),
              Text(
                'Color',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Colors.black,
                  Colors.pink,
                  Colors.red,
                  Colors.blue,
                ].map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: selectedColor == color
                            ? Border.all(color: Theme.of(context).primaryColor, width: 3)
                            : null,
                      ),
                      child: CircleAvatar(
                        backgroundColor: color,
                        radius: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
               Orangebtn(text: 'Add to cart', onTap: (){
                  dbHelper.insert(
                    CartModel(
                      url: widget.url,
                      id: widget.id,
                      title: shortenProductTitle(widget.title),
                      size: selectedSize ?? 'S',
                      price: widget.price,
                      color: selectedColor?.value ?? Colors.black.value,
                    ),
                  ).then((value) {
                    cart.addTotalPrice(widget.price);
                    cart.addCounter();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Added')));
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                }
                ),
            ],
          ),
        ),
      ),
    );
  }
}

