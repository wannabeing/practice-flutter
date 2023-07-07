import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';

class PreviewButtonWidget extends StatefulWidget {
  final String text;
  final Function onTap;
  final bool isActive;

  const PreviewButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.isActive,
  });

  @override
  State<PreviewButtonWidget> createState() => _PreviewButtonWidgetState();
}

class _PreviewButtonWidgetState extends State<PreviewButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isActive,
      child: GestureDetector(
        onTap: () => widget.onTap(),
        child: AnimatedContainer(
          duration: Utils.duration300, // 애니메이션 지속 시간 설정
          width: Sizes.width / 2.5,
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size14,
            horizontal: Sizes.size28,
          ),
          decoration: BoxDecoration(
            color: widget.isActive
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(Sizes.size14),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isActive ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
