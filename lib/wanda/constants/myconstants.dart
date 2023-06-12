import 'package:flutter/widgets.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class MyConstants {
  static final List<Shadow> textShadow = [
    const Shadow(
      blurRadius: Sizes.size10,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ];

  static const Duration duration = Duration(
    milliseconds: 300,
  );
}
