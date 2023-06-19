import 'package:flutter/cupertino.dart';

class UserExitAlertWidget extends StatelessWidget {
  const UserExitAlertWidget({super.key});

  // 🚀 회원탈퇴 버튼 함수
  void _onUserExit(BuildContext context) {}

  // 🚀 취소 버튼 함수
  void _onCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text("정말로 탈퇴하시겠습니까?"),
      message: const Text("탈퇴 시 사용자의 모든 정보가 사라지고 복구가 불가능합니다."),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => _onUserExit(context),
          isDestructiveAction: true,
          child: const Text("회원탈퇴"),
        ),
        CupertinoActionSheetAction(
          onPressed: () => _onCancel(context),
          child: const Text("취소"),
        ),
      ],
    );
  }
}
