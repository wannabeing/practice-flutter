import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';

class MyPageSliverPersistentTabbar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // tarbar
    return Container(
      color: Utils.isDarkMode(context) ? Colors.black : Colors.grey.shade50,
      child: TabBar(
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey.shade500,
        labelColor:
            Utils.isDarkMode(context) ? Colors.white : Colors.grey.shade900,
        indicatorColor:
            Utils.isDarkMode(context) ? Colors.white : Colors.grey.shade900,
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

  @override
  double get maxExtent => Sizes.height / 21;

  @override
  double get minExtent => Sizes.height / 21;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
