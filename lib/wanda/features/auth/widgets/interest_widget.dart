import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/myconstants.dart';
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
  late dynamic isFullList;

  // 🚀 부모위젯에게 전달하는 함수
  void _handleCallback() {
    isFullList = widget.callback(widget.interestText); // callback

    if (isFullList != null) return;

    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleCallback(),
      child: Column(
        children: [
          AnimatedContainer(
            duration: MyConstants.duration,
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size16,
              horizontal: Sizes.size24,
            ),
            decoration: BoxDecoration(
              color:
                  _isSelected ? Theme.of(context).primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(
                Sizes.size32,
              ),
              border: Border.all(
                color: _isSelected
                    ? Colors.transparent
                    : Colors.black.withOpacity(0.2),
              ),
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
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
