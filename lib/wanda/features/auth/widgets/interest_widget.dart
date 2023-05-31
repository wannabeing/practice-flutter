import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class InterestWidget extends StatefulWidget {
  final String interestText; // 관심분야
  final Function(String) callback; // 부모위젯에게 전달할 callback 함수

  const InterestWidget({
    super.key,
    required this.interestText,
    required this.callback,
  });

  @override
  State<InterestWidget> createState() => _InterestWidgetState();
}

class _InterestWidgetState extends State<InterestWidget> {
  bool _isSelected = false; // 선택했는지 여부

  // 🚀 부모위젯에게 전달하는 함수
  void _handleCallback() {
    widget.callback(widget.interestText); // callback

    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleCallback(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Text(
          widget.interestText,
          style: TextStyle(
            color: _isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
