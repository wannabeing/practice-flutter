import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String money; // 통화 이름
  final String price; // 얼마있음
  final String unit; // 단위
  final IconData icon; // 아이콘
  final bool _isInverted; // 색상 반전
  final double _offsetY; // offset Y값

  const CardWidget({
    super.key,
    required this.money,
    required this.price,
    required this.unit,
    required this.icon,
    bool? isInverted, // 값이 없으면 기본적으로 null로 설정합니다.
    double? offsetY,
  })  : _isInverted = isInverted ?? false, // 값이 null인 경우 false로 초기화
        _offsetY = offsetY ?? 0; // 값이 null인 경우 0 초기화

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, _offsetY),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: _isInverted ? Colors.white : Colors.blueAccent,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: _isInverted ? Border.all(color: Colors.grey.shade400) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    money,
                    style: TextStyle(
                      color: _isInverted ? Colors.blueAccent : Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: _isInverted ? Colors.blueAccent : Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " $unit",
                        style: TextStyle(
                          color: _isInverted
                              ? Colors.blueAccent.shade200
                              : Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 1.5,
                child: Transform.translate(
                  offset: const Offset(-10, 10),
                  child: Icon(
                    icon,
                    color: _isInverted ? Colors.blueAccent : Colors.white,
                    size: 90,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
