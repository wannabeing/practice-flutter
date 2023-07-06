import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class PreviewTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final String? errorText;

  const PreviewTextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Sizes.width / 4),
      child: TextField(
        controller: textEditingController,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
