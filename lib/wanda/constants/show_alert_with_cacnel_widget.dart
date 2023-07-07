import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class ShowAlertWithCacnelBtn extends ConsumerStatefulWidget {
  final Function confirmFunc; // 확인버튼 함수
  final Function? cancelFunc; // 취소버튼 함수 ?
  final String titleText; // 메인제목 텍스트
  final String subtitleText; // 부제목 텍스트 ?
  final String confirmBtnText; // 확인버튼 텍스트 ?
  final String cancelBtnText; // 취소버튼 텍스트 ?
  final bool cancelBtn; // 취소버튼 유무 ?

  const ShowAlertWithCacnelBtn({
    super.key,
    // required
    required this.confirmFunc,
    required this.titleText,

    // null일 수도
    this.cancelFunc,

    // null이어도 기본값 SET
    subtitleText,
    confirmBtnText,
    cancelBtnText,
    cancelBtn,
  })  : subtitleText = subtitleText ?? "",
        confirmBtnText = confirmBtnText ?? "확인",
        cancelBtnText = cancelBtnText ?? "취소",
        cancelBtn = cancelBtn ?? false;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowAlertWithCacnelBtnState();
}

class _ShowAlertWithCacnelBtnState
    extends ConsumerState<ShowAlertWithCacnelBtn> {
  // 🚀 확인버튼 함수
  void _onConfirm() {
    widget.confirmFunc();
  }

// 🚀 취소버튼 함수
  void _onCancel() {
    if (widget.cancelFunc != null) {
      widget.cancelFunc!();
    }
    // ✅ default: context.pop()
    else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.vheight40,
          Text(
            widget.titleText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.width / 22,
            ),
          ),
          Gaps.vheight60,
          Opacity(
            opacity: 0.7,
            child: Text(
              widget.subtitleText,
              style: const TextStyle(),
            ),
          ),
          Gaps.vheight30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => _onConfirm(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.width / 15,
                    vertical: Sizes.size14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    widget.confirmBtnText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // ✅ 취소 버튼
              if (widget.cancelBtn)
                GestureDetector(
                  onTap: () => _onCancel(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.width / 15,
                      vertical: Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.shade100,
                    ),
                    child: Text(
                      widget.cancelBtnText,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
