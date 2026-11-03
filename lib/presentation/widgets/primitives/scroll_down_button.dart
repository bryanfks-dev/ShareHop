import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

class ScrollDownButton extends HookWidget {
  const new({
    required this.scrollController,
    this.visibilityThreshold = 200,
    super.key,
  });

  final ScrollController scrollController;
  final double visibilityThreshold;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final show = useState(true);

    void handleOnScroll() {
      if (!scrollController.hasClients) {
        return;
      }

      final position = scrollController.position;
      final shouldShow =
          position.maxScrollExtent - position.pixels > visibilityThreshold;
      if (shouldShow != show.value) {
        show.value = shouldShow;
      }
    }

    void scrollToBottom() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }

    void handleOnPress() {
      scrollToBottom();
    }

    useEffect(() {
      scrollController.addListener(handleOnScroll);

      return () => scrollController.removeListener(handleOnScroll);
    }, [scrollController, visibilityThreshold]);

    return AnimatedScale(
      scale: show.value ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: FButton.icon(
        size: .lg,
        style: .delta(
          decoration: .delta([
            .all(
              .boxDelta(
                borderRadius: theme.style.borderRadius.xl3,
                boxShadow: theme.style.shadow,
              ),
            ),
          ]),
        ),
        onPress: handleOnPress,
        child: const Icon(FLucideIcons.chevronDown),
      ),
    );
  }
}
