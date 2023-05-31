import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/widgets/interest_widget.dart';
import 'package:may230517/wanda/features/onboard/first_onboard_screen.dart';

// 관심분야 예시 리스트
const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final ScrollController _scrollController = ScrollController();
  List<String> newInterests = []; // 사용자의 관심분야 목록
  bool _showTitle = false; // appBar Title 활성화 여부
  bool _isInterested = false; // 관심분야 하나라도 선택 여부

  // 🚀 버튼 함수 (스킵 & 다음)
  void _onSubmit() {
    // 스킵하기 클릭
    if (_isInterested == false) {}

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FirstOnboardScreen(),
      ),
    );
  }

  /*
   🚀 관심분야 정리 함수
    result는 callback으로 전달받은 관심분야임
  */
  void _onInterest(String result) {
    if (newInterests.contains(result)) {
      newInterests.remove(result); // 중복된 result를 리스트에서 제거
    } else {
      newInterests.add(result); // 중복되지 않은 result를 리스트에 추가
    }
    // 리스트 데이터가 있는지에 따라 _isInterested 업데이트
    _isInterested = newInterests.isNotEmpty;
    setState(() {});
  }

  // 🚀 스크롤 감지 함수
  void _onScroll() {
    // ✅ offset이 100 넘어가면 상태 변경
    if (_scrollController.offset > 100) {
      // ✅ 이미 true라면 return (중복 setState 방지)
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // ✅ Scroll Listen
    _scrollController.addListener(() {
      _onScroll(); // 스크롤 할 때마다, 함수 실행
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: const Text("관심분야를 선택해주세요!"),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size32,
              vertical: Sizes.size24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  "관심이 가는 분야가 있으신가요?",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  "추천해드릴게요.",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.grey.shade700,
                  ),
                ),
                Gaps.v52,
                Wrap(
                  spacing: Sizes.size16,
                  runSpacing: Sizes.size16,
                  children: [
                    for (var interest in interests) ...[
                      InterestWidget(
                        callback: _onInterest,
                        interestText: interest,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300), // 테두리 색상 설정
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size32,
            horizontal: Sizes.size20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ⭐️ 스킵버튼
              GestureDetector(
                onTap: () => _onSubmit(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간 설정
                  width: Sizes.width / 2.5,
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size14,
                    horizontal: Sizes.size28,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(Sizes.size4),
                  ),
                  child: const Text(
                    "스킵하기",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // ⭐️ 다음버튼
              GestureDetector(
                onTap: () => _onSubmit(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간 설정
                  width: Sizes.width / 2.5,
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size14,
                    horizontal: Sizes.size28,
                  ),
                  decoration: BoxDecoration(
                    color: _isInterested
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(Sizes.size4),
                  ),
                  child: Text(
                    "다음",
                    style: TextStyle(
                      color:
                          _isInterested ? Colors.white : Colors.grey.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
