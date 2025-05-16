import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  final controller, hintText,suffixIcon,autofillHint;
  ReusableTextFormField({required this.controller , required this.hintText,this.autofillHint,this.suffixIcon,super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          autofillHints: autofillHint != null ? [autofillHint!] : null,
          style: TextStyle(
              color: Theme.of(context).primaryColorLight
          ),
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(Icons.remove_red_eye_outlined),
              fillColor: Theme.of(context).primaryColorLight,
              focusColor: Theme.of(context).secondaryHeaderColor,
              focusedBorder:OutlineInputBorder(
                borderSide:  BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
        ),
      );
  }
}
