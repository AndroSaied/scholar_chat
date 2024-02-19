import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key, required this.hintText, this.onChanged, this.obscure = false});

  Function(String)? onChanged;
  final String hintText;
  bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure!,
      validator: (value) {
        if (value!.isEmpty) {
          return "field is required";
        }
        
      },
      onChanged: onChanged,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,)
                ),
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white),
              ),
            );
  }
}