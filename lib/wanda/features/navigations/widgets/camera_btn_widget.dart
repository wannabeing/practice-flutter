import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class CameraBtnWidget extends StatelessWidget {
  const CameraBtnWidget({super.key});

  // 🚀 버튼 함수
  void _onTap() {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _onTap(),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: Sizes.height / 40,
              child: Container(
                padding: const EdgeInsets.all(Sizes.size14),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 10,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.camera,
                    size: Sizes.size32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Sizes.width / 10,
              height: Sizes.height / 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "카메라",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
