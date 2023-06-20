import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:may230517/wanda/features/settings/widgets/logout_alert_widget.dart';
import 'package:may230517/wanda/features/settings/widgets/user_exit_alert_widget.dart';

class SettingMainScreen extends StatelessWidget {
  const SettingMainScreen({super.key});

  // 🌐 RouteName
  static String routeName = "/settings";

  // 🚀 로그아웃 모달창 함수
  void _showLogoutModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const LogoutAlertWidget();
      },
    );
  }

  // 🚀 회원탈퇴 모달창 함수
  void _showUserExitModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return const UserExitAlertWidget();
      },
    );
  }

  // 🚀 앱정보 모달창 함수
  void _showAppInfo(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: "완다",
      applicationVersion: "1.0.0",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
      ),
      body: ListView(
        children: [
          // ✅ 로그아웃
          ListTile(
            onTap: () => _showLogoutModal(context),
            title: const Text("로그아웃"),
          ),
          // ✅ 회원탈퇴
          ListTile(
            onTap: () => _showUserExitModal(context),
            title: const Text("회원탈퇴"),
          ),
          // ✅ 앱 정보
          ListTile(
            onTap: () => _showAppInfo(context),
            title: const Text("앱 정보"),
            subtitle: const Text("자세히보기"),
          ),
        ],
      ),
    );
  }
}
