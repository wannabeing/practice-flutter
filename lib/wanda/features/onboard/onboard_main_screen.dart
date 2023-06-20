import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/signup_main_screen.dart';
import 'package:may230517/wanda/features/auth/widgets/submit_btn.dart';
import 'package:may230517/wanda/features/onboard/widgets/onboard_widget.dart';

class OnboardMainScreen extends StatefulWidget {
  const OnboardMainScreen({super.key});

  // 🌐 RouteName
  static String routeName = "/onboarding";

  @override
  State<OnboardMainScreen> createState() => _OnboardMainScreenState();
}

class _OnboardMainScreenState extends State<OnboardMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isActive = false;

  // 🚀 탭 인덱스 핸들링 함수
  void _handleTabIndex() {
    // 버튼 활성화 항상 false
    setState(() {
      _isActive = false;
    });
    // 마지막 탭이면 버튼 활성화 true
    if (_tabController.index == _tabController.length - 1) {
      setState(() {
        _isActive = true;
      });
    }
  }

  // 🚀 다음 스크린으로 이동
  void _nextScreen() {
    context.go(SignupMainScreen.routeName);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _handleTabIndex();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              controller: _tabController,
              selectedColor: Theme.of(context).primaryColor,
              borderStyle: BorderStyle.none,
              color: Colors.grey.shade300,
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            OnboardWidget(
                firstTitle: "대출주도권을",
                secondTitle: "당신에게로",
                firstSubTitle: "대출도 더 유리한 조건으로",
                secondSubTitle: "비교하고 관리하고 갈아타세요!",
                bottomText: "안심하시고 투자하세요.",
                imageSrc: "assets/images/first_onboard.png"),
            OnboardWidget(
                firstTitle: "62개 최다 금융사",
                secondTitle: "한 번에 비교",
                firstSubTitle: "비대면으로 대출조건 확인부터",
                secondSubTitle: "입금까지 단 6분이면 가능!",
                bottomText: "신용점수에도 영향이 없어요.",
                imageSrc: "assets/images/second_onboard.png"),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade50,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size32,
            horizontal: Sizes.size20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SubmitButton(
                text: "시작하기",
                onTap: () => _nextScreen(),
                isActive: _isActive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
