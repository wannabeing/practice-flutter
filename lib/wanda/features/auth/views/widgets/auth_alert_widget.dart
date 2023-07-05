import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class AuthAlertWidget extends ConsumerWidget {
  final String? text;

  const AuthAlertWidget({
    super.key,
    this.text,
  });

  // 🚀 확인 함수
  void _onTap(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.vheight40,
          Text(
            text ?? "이미 존재하는 계정입니다.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.width / 22,
            ),
          ),
          Gaps.vheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _onTap(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.width / 15,
                    vertical: Sizes.size14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "확인",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
