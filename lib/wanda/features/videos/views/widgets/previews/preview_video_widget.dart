import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:video_player/video_player.dart';

class PreviewVideoWidget extends StatelessWidget {
  final VideoPlayerController videoPlayerController;
  final Function onTap;
  const PreviewVideoWidget({
    super.key,
    required this.videoPlayerController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        constraints: BoxConstraints(maxWidth: Sizes.width / 2),
        height: Sizes.height / 4,
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: VideoPlayer(
              videoPlayerController,
            ),
          ),
        ),
      ),
    );
  }
}
