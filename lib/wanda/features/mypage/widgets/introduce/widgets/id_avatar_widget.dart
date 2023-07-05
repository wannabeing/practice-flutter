import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/mypage/vms/avatar_img_vm.dart';

class IntroduceAvatarWidget extends ConsumerWidget {
  const IntroduceAvatarWidget({
    super.key,
    required this.avatarURL,
  });

  final String avatarURL; // 이미지 URL 주소

  // 🚀 아바타 클릭 함수
  Future<void> _onTapAvatar(WidgetRef ref) async {
    // 사용자가 선택한 이미지파일
    final selectImg = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxWidth: 150,
      maxHeight: 150,
    );
    // ❌ 취소할 경우 return
    if (selectImg == null) return;

    // ✅ 이미지파일을 선택했을 경우
    final imgFile = File(selectImg.path);
    // 🚀 fireStorage 업로드 요청
    await ref.read(avatarProvider.notifier).uploadFile(imgFile);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🔥 아바타이미지 로딩 여부
    final avatarLoading = ref.watch(avatarProvider).isLoading;

    return GestureDetector(
      onTap: () => avatarLoading ? null : _onTapAvatar(ref),
      child: avatarLoading
          // ✅ 로딩중
          ? SizedBox(
              width: Sizes.width / 10,
              child: const CircularProgressIndicator.adaptive(),
            )
          // ✅ 이미지 위젯
          : Stack(
              children: [
                CircleAvatar(
                  radius: Sizes.width / 10,
                  foregroundImage:
                      avatarURL.isNotEmpty ? NetworkImage(avatarURL) : null,
                  backgroundImage: avatarURL.isEmpty
                      ? const AssetImage("assets/images/avatar.png")
                      : null,
                  backgroundColor: Colors.grey.shade200,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    padding: const EdgeInsets.all(7),
                    child: FaIcon(
                      FontAwesomeIcons.camera,
                      color: Colors.white,
                      size: Sizes.width / 30,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
