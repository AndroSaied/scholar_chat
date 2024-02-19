import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.nameButton, this.onTap});

  VoidCallback? onTap;

  final String nameButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Text(
          nameButton,
          style: const TextStyle(color: kPrimaryColor, fontSize: 23),
        ),
      ),
    );
  }
}
