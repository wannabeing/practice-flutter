import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderWatchWidget extends ConsumerWidget {
  final Widget widget;
  final bool isLoading;

  const ProviderWatchWidget({
    super.key,
    required this.widget,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: Opacity(
            opacity: isLoading ? 0.5 : 1,
            child: widget,
          ),
        ),
        // ✅ 로딩바
        if (isLoading)
          const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator.adaptive(),
          ),
      ],
    );
  }
}
