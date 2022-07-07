// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.onTap,
    this.buttonColor,
    this.textColor,
    this.val,
    this.borderColor,
    required this.buttonText,
    Key? key,
  }) : super(key: key);

  VoidCallback onTap;
  Color? buttonColor, textColor, borderColor;
  double? val;
  String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: buttonColor ?? Colors.black87,
          borderRadius: BorderRadius.circular(val ?? 0),
          border: Border.all(color: borderColor ?? Colors.black)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: textColor ?? Colors.white60,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
