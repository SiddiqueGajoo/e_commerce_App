import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SizeBtn extends StatefulWidget {
  final text;
  Color color;
   SizeBtn({required this.text,this.color = Colors.black,super.key});

  @override
  State<SizeBtn> createState() => _SizeBtnState();
}

class _SizeBtnState extends State<SizeBtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          widget.color = (widget.color == Theme.of(context).primaryColorDark) ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Text(widget.text,style: GoogleFonts.poppins(
            color: widget.color
        ),),
      ),
    );
  }
}
