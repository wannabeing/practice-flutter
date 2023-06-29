import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/settings/vms/setting_config_vm.dart';

class AuthButton extends ConsumerWidget {
  final String text;
  final FaIcon icon;
  final VoidCallback onTap;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.height / 50,
            horizontal: Sizes.width / 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: ref.watch(settingConfigProvider).darkTheme
                  ? Colors.white70
                  : Colors.black45,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.width / 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
