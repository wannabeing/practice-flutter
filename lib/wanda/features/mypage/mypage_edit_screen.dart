import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/widgets/input_widget.dart';
import 'package:may230517/wanda/features/auth/views/widgets/submit_btn.dart';
import 'package:may230517/wanda/features/auth/vms/user_vm.dart';

class MyPageEditScreen extends ConsumerStatefulWidget {
  const MyPageEditScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyPageEditScreenState();
}

class _MyPageEditScreenState extends ConsumerState<MyPageEditScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  String _displayValue = '';
  String _birthValue = '';

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 닉네임 유효성 검사 함수
  String? _getDisplayNameValid() {
    if (_displayValue.isEmpty) return null;

    if (_displayValue.length > 8) {
      return "닉네임은 8자 이하입니다.";
    }
    return null;
  }

  // 🚀 생년월일 유효성 검사 함수
  String? _getBirthValid() {
    if (_birthValue.isEmpty) return null;

    if (_birthValue.contains(RegExp(r"[a-z]"))) {
      return "문자는 들어갈 수 없습니다.";
    }
    if (!_birthValue.contains(RegExp(r"[0-9]"))) {
      return "숫자가 들어가야 합니다.";
    }

    if (_birthValue.length != 8) return "8자리여야 합니다.";
    if (!_birthValue.startsWith(RegExp(r"19[5-9][0-9]|20[0-9]{2}"))) {
      return "생년을 제대로 입력해주세요.";
    }

    String month = _birthValue.substring(4, 6);
    if (!RegExp(r"(0[1-9]|1[0-2])").hasMatch(month)) {
      return "존재하지 않는 월 입니다.";
    }

    String day = _birthValue.substring(6, 8);
    if (!RegExp(r"(0[1-9]|[1-2][0-9]|3[01])").hasMatch(day)) {
      return "존재하지 않는 일 입니다.";
    }

    return null;
  }

  Future<void> _onUpdate() async {
    final result = await ref.read(userProvider.notifier).updateUserModel(
          newDisplayName: _displayValue,
          newBirth: _birthValue,
        );

    if (result) {
      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // 유저데이터 가져오기
    final userData = ref.read(userProvider);
    // 유저데이터로 변수 초기화
    _displayValue = userData.value!.displayName;
    _birthValue = userData.value!.birth;
    _displayNameController.text = _displayValue;
    _birthController.text = _birthValue;

    // 사용자 입력 텍스트 Listen
    _displayNameController.addListener(() {
      setState(() {
        _displayValue = _displayNameController.value.text;
      });
    });
    // 사용자 입력 텍스트 Listen
    _birthController.addListener(() {
      _birthValue = _birthController.value.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _displayNameController.removeListener(() {});
    _birthController.removeListener(() {});
    _displayNameController.dispose();
    _birthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onUnfocusKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("프로필 수정"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width / 15,
            vertical: Sizes.height / 50,
          ),
          child: Column(
            children: [
              InputWidget(
                controller: _displayNameController,
                maxLength: 8,
                hintText: "닉네임 수정하기",
                labelText: "닉네임",
                textInputAction: TextInputAction.next,
                errorText: _getDisplayNameValid(),
              ),
              InputWidget(
                controller: _birthController,
                maxLength: 8,
                type: "birth",
                hintText: "생일 수정하기",
                labelText: "생년월일 8자리",
                textInputAction: TextInputAction.next,
                errorText: _getBirthValid(),
              ),
              Gaps.vheight20,
              Align(
                alignment: Alignment.bottomCenter,
                child: SubmitButton(
                  text: "수정하기",
                  onTap: () async => await _onUpdate(),
                  isActive: _getDisplayNameValid() == null &&
                      _getBirthValid() == null &&
                      _displayValue.isNotEmpty &&
                      _birthValue.isNotEmpty &&
                      !ref.watch(userProvider).isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
