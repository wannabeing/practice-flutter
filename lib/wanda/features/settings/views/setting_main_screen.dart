import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/features/settings/views/widgets/logout_alert_widget.dart';
import 'package:may230517/wanda/features/settings/views/widgets/user_exit_alert_widget.dart';
import 'package:may230517/wanda/features/settings/vms/setting_config_vm.dart';

class SettingMainScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
      ),
      body: ListView(
        children: [
          // ✅ 다크모드 설정
          SwitchListTile.adaptive(
            value: ref.watch(settingConfigProvider).darkTheme,
            onChanged: (value) {
              ref
                  .read(settingConfigProvider.notifier)
                  .setConfigDarkTheme(value);
            },
            title: const Text("다크모드"),
          ),
          // ✅ 비디오 오토플레이
          SwitchListTile.adaptive(
            value: ref.watch(settingConfigProvider).videoAutoplay,
            onChanged: (value) {
              ref
                  .read(settingConfigProvider.notifier)
                  .setConfigVideoAutoplay(value);
            },
            title: const Text("비디오 오토플레이"),
          ),
          // // ✅ 비디오 음소거
          SwitchListTile.adaptive(
            value: ref.watch(settingConfigProvider).videoMute,
            onChanged: (value) {
              ref
                  .read(settingConfigProvider.notifier)
                  .setConfigVideoMute(value);
            },
            title: const Text("비디오 음소거"),
          ),
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
