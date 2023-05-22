import 'package:flutter/material.dart';

class WebtoonDetailScreen extends StatelessWidget {
  String id, title, thumb;

  WebtoonDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "SBAggro",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
    );
  }
}
