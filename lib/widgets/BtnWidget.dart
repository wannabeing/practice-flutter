import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String textValue;

  const BtnWidget({
    super.key,
    required this.bgColor,
    required this.textColor,
    required this.textValue,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 15,
          ),
          child: Text(
            textValue,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
