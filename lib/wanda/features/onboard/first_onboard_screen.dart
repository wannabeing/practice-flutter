import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class FirstOnboardScreen extends StatefulWidget {
  const FirstOnboardScreen({super.key});

  @override
  State<FirstOnboardScreen> createState() => _FirstOnboardScreenState();
}

class _FirstOnboardScreenState extends State<FirstOnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(Sizes.height / 20), // TabPageSelector의 높이 지정
            child: TabPageSelector(
              selectedColor: Theme.of(context).primaryColor,
              borderStyle: BorderStyle.solid,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
                vertical: Sizes.size24,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "대출주도권을",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "당신에게로",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
                vertical: Sizes.size24,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "62개 최다 금융사",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "한 번에 비교",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
