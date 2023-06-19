import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isActive;

  const SubmitButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isActive,
  });

  // 🚀 버튼 클릭 함수
  void _onTap(BuildContext context) {
    if (!isActive) return; // 비활성화시 실행 X
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: AnimatedContainer(
          duration: Utils.duration300,
          decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).primaryColor
                : Utils.isDarkMode(context)
                    ? Colors.grey.shade500
                    : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(Sizes.size16),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size20,
          ),
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade600,
            ),
            duration: Utils.duration300,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Sizes.size18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
