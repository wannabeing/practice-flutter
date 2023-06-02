import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class OnboardWidget extends StatelessWidget {
  final String firstTitle,
      secondTitle,
      firstSubTitle,
      secondSubTitle,
      bottomText,
      imageSrc;
  const OnboardWidget({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    required this.firstSubTitle,
    required this.secondSubTitle,
    required this.bottomText,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size32,
        vertical: Sizes.size24,
      ),
      child: Column(
        children: [
          Gaps.vheight20,
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      firstTitle,
                      style: const TextStyle(
                        fontSize: Sizes.size32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      secondTitle,
                      style: const TextStyle(
                        fontSize: Sizes.size32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gaps.vheight40,
                Column(
                  children: [
                    Text(
                      firstSubTitle,
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      secondSubTitle,
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: SizedBox(
              width: Sizes.width,
              child: Image.asset(imageSrc),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline_outlined,
                  size: Sizes.size32,
                  color: Theme.of(context).primaryColor,
                ),
                Gaps.h5,
                Text(
                  bottomText,
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
