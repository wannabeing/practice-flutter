import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/settings/vms/setting_config_vm.dart';

class MyPageIntroduceTabbarWidget extends ConsumerWidget {
  const MyPageIntroduceTabbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 사용자설정 다크테마 여부 가져오기
    final isDarkTheme = ref.watch(settingConfigProvider).darkTheme;

    return SliverAppBar(
      pinned: true, // 고정
      primary: false,
      toolbarHeight: Sizes.height / 20,
      flexibleSpace: TabBar(
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor:
            isDarkTheme ? Colors.grey.shade700 : Colors.grey.shade500,
        labelColor: isDarkTheme ? Colors.white : Colors.grey.shade900,
        indicatorColor: isDarkTheme ? Colors.white : Colors.grey.shade900,
        tabs: [
          // indicator 너비때문에 pdding 설정함
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width / 20,
            ),
            child: const Icon(Icons.grid_on_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width / 20,
            ),
            child: const Icon(Icons.video_collection_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width / 20,
            ),
            child: const FaIcon(FontAwesomeIcons.heart),
          ),
        ],
      ),
    );
  }
}
