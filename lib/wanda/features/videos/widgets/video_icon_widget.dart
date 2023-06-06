import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/shadows.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class VideoIconWidget extends StatelessWidget {
  final IconData faIconData;
  final String dataText;
  const VideoIconWidget({
    super.key,
    required this.faIconData,
    required this.dataText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // 그림자의 색상 설정
                spreadRadius: 0.5, // 그림자의 확산 범위 설정
                blurRadius: 5, // 그림자의 흐림 정도 설정
                offset: const Offset(0, 2), // 그림자의 위치 설정
              ),
            ],
          ),
          child: FaIcon(
            faIconData,
            color: Colors.white,
            size: Sizes.width / 12,
          ),
        ),
        Gaps.v5,
        Text(
          dataText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: MyShadows.textShadow,
          ),
        ),
      ],
    );
  }
}