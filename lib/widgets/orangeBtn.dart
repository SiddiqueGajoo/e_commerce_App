import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orangebtn extends StatelessWidget {
  final text;
   const Orangebtn({required this.text,required this.onTap,super.key});
   final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height*.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColor),
        child: Center(
          child: Text(
            text,
            style:
            GoogleFonts.sora(fontSize: 14, color: Theme.of(context).primaryColorLight),
          ),
        ),
      ),
    );
  }
}
