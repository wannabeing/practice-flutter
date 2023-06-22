import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class ReLoadingWidget extends StatelessWidget {
  const ReLoadingWidget({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white),
            Gaps.vheight40,
            const Text(
              "로딩중...",
              style: TextStyle(color: Colors.white),
            ),
            Gaps.vheight20,
            GestureDetector(
              onTap: () => onTap(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width / 10,
                  vertical: Sizes.height / 50,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "갤러리에서 가져오기",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
