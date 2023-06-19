import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/utils.dart';

class NavTabWidget extends StatelessWidget {
  final IconData tabIcon, selectedIcon;
  final String tabName;
  final bool isSelected;
  final Function onTap;

  const NavTabWidget({
    super.key,
    required this.tabIcon,
    required this.selectedIcon,
    required this.tabName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior:
            HitTestBehavior.translucent, // 이 옵션 때문에 아이콘 근처만 클릭해도 onTap 기능 활성화
        onTap: () => onTap(),
        child: AnimatedOpacity(
          opacity: isSelected ? 1.0 : 0.5,
          duration: Utils.duration300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                isSelected ? selectedIcon : tabIcon,
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.black,
              ),
              Gaps.v3,
              Text(
                tabName,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
