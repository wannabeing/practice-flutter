import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class LogoutAlertWidget extends StatelessWidget {
  const LogoutAlertWidget({super.key});

  // 🚀 로그아웃 버튼 함수
  void _onLogout() {}

  // 🚀 취소 버튼 함수
  void _onCancel(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(
        left: Sizes.width / 6,
        right: Sizes.width / 6,
        top: Sizes.height / 20,
        bottom: Sizes.height / 30,
      ),
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "정말 로그아웃 하시겠어요?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.width / 22,
            ),
          ),
          Gaps.vheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _onLogout(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.width / 18,
                    vertical: Sizes.size14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "로그아웃",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _onCancel(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.width / 15,
                    vertical: Sizes.size14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey.shade100,
                  ),
                  child: const Text(
                    "취소",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
