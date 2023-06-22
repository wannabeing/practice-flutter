import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class ReToggleIconButton extends StatelessWidget {
  const ReToggleIconButton({
    super.key,
    required this.onTap,
    required this.iconData,
    isChange,
    this.changeIconData,
  }) : isChange = isChange ?? false;

  final Function onTap; // 탭 함수
  final IconData iconData; // 기존 아이콘
  final bool isChange; // 탭시 변화 여부
  final IconData? changeIconData; // 탭시 변화 아이콘

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: Sizes.width / 30,
          vertical: Sizes.height / 50,
        ),
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isChange ? changeIconData : iconData,
          color: isChange ? Colors.amber : Colors.white,
        ),
      ),
    );
  }
}
