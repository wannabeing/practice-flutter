import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isSearchTextEmpty = true; // 검색어 존재 여부 확인

  // 🚀 검색텍스트 감지 함수
  void _onSearchChanged(String val) {
    // 텍스트가 존재하면 true
    if (val == '') {
      _isSearchTextEmpty = true;
    } else {
      _isSearchTextEmpty = false;
    }

    setState(() {});
  }

  // 🚀 검색텍스트 제출 함수
  void _onSearchSubmitted(String val) {}

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(() {});
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: _textEditingController,
      onChanged: (value) => _onSearchChanged(value), // onChagned
      onSubmitted: (value) => _onSearchSubmitted(value), // onSubmitted
      cursorColor: Theme.of(context).primaryColor,

      decoration: InputDecoration(
        hintText: "검색",
        filled: true, // input 채우기
        fillColor: Colors.grey.shade300,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16, // textfield 내부 padding
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none, // 테두리 활성화 false
        ),
        // ✅ 돋보기 아이콘 (메시지 제출 아이콘)
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width / 50,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () =>
                    _onSearchSubmitted(_textEditingController.value.text),
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.grey.shade600,
                ),
              )
            ],
          ),
        ),
        // ✅ 메시지삭제 아이콘
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: Sizes.width / 35,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 키보드창에 글자가 있고 키보드활성화 되어있을 때만 보여주기
              // 누르면 메시지 전체 삭제
              if (!_isSearchTextEmpty && FocusScope.of(context).hasFocus)
                GestureDetector(
                  onTap: () => _textEditingController.text = '',
                  child: FaIcon(
                    FontAwesomeIcons.solidCircleXmark,
                    size: Sizes.width / 20,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
