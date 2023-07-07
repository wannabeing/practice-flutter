import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/signup_main_screen.dart';
import 'package:may230517/wanda/features/auth/vms/email_auth_vm.dart';

class LogoutAlertWidget extends ConsumerWidget {
  const LogoutAlertWidget({super.key});

  // 🚀 로그아웃 버튼 함수
  Future<void> _onLogout(WidgetRef ref, BuildContext context) async {
    await ref.read(emailAuthProvider.notifier).signOut();

    if (context.mounted) {
      context.go(SignupMainScreen.routeName);
    }
  }

  // 🚀 취소 버튼 함수
  void _onCancel(BuildContext context) {
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
            "로그아웃",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.width / 22,
            ),
          ),
          Gaps.vheight60,
          const Opacity(
            opacity: 0.7,
            child: Text(
              "정말 로그아웃 하시겠어요?",
            ),
          ),
          Gaps.vheight30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _onLogout(ref, context),
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
