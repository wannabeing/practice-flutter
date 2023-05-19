import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/widgets/BtnWidget.dart';
import 'package:may230517/widgets/CardWidget.dart';

void main() {
  runApp(const App());
}

// root Widget은 Material/Cupertino 둘 중 하나를 반드시 return
// google이 만들었으니까 Material을 기본으로 가자..

// 항상 Scaffold(구조)를 설정하자.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "최혁",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "님 안녕하세요!",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    FaIcon(
                      FontAwesomeIcons.solidBell,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "총 자산",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey.shade500,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "4,300원",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BtnWidget(
                              bgColor: Colors.blue.shade50,
                              textValue: "채우기",
                              textColor: Colors.blueAccent,
                            ),
                            const BtnWidget(
                              bgColor: Colors.blueAccent,
                              textValue: "보내기",
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "내 지갑",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " 3",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "더보기",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const CardWidget(
                          money: "EURO",
                          price: "1,111",
                          unit: "EUR",
                          icon: Icons.euro_outlined,
                        ),
                        const CardWidget(
                          money: "BITCOIN",
                          price: "1,111",
                          unit: "BTC",
                          icon: Icons.currency_bitcoin_outlined,
                          isInverted: true,
                          offsetY: -20,
                        ),
                        const CardWidget(
                          money: "KRW",
                          price: "1,111",
                          unit: "WON",
                          icon: FontAwesomeIcons.wonSign,
                          offsetY: -40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
