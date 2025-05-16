import 'package:e_commerce_app/Database/db_helper.dart';
import 'package:e_commerce_app/model/cart_model.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/widgets/ReusableRow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/widgets/orangeBtn.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
                child: FutureBuilder(
                    future: cart.getData(),
                    builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
                      if(!snapshot.hasData || snapshot.data == null){
                        return const Center(child: Text('No data found'));
                      }if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Uh oh Nothing here\n Your cart is empty',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        );
                      }
                      else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                          return  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height*.18,
                                      width: width*.3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot.data![index].url.toString()),
                                          ),
                                          borderRadius: BorderRadius.circular(12)),
                                    ),
                                    Expanded(
                                        child:  ListTile(
                                            title: Text(
                                                snapshot.data![index].title.toString(),style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            )),
                                            trailing:  Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children:  [
                                                InkWell(
                                                  onTap: (){
                                                    dbHelper!
                                                        .delete(snapshot.data![index].id);
                                                    cart.removeCounter();
                                                    cart.removeTotalPrice(double.parse(
                                                        snapshot.data![index].price
                                                            .toString()));
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('\$'+snapshot.data![index].price.toString(),style: GoogleFonts.poppins(
                                                  fontSize: 24,
                                                ),),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Color(snapshot.data![index].color),
                                                      radius: 12,
                                                    ),
                                                    SizedBox(width: width*.05,),
                                                    Text(snapshot.data![index].size.toString(),style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: Theme.of(context).primaryColor
                                                    ),)
                                                  ],
                                                )
                                              ],
                                            ))
                                    )

                                  ]),
                          );
                        });
                      }
                    })),
        Consumer<CartProvider>(builder: (context, value, child) {
          return Visibility(
            visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                ? false
                : true,
            child: Column(
              children: [
                ReusableRow(
                    title: 'Sub Total',
                    value: r'$' + value.getTotalPrice().toStringAsFixed(2)),
                Orangebtn(text: 'Check Out',onTap: (){
                },)
              ],
            ),
          );
        })
          ]),
        ),
      ),
    );
  }
}
