import 'package:flutter/material.dart';

/// Custom animations for navigation transitions
class NavigationAnimations {
  static const Duration transitionDuration = Duration(milliseconds: 500);
  static const Curve transitionCurve = Curves.easeInOut;
}

/// Animation for rail transitions (slide in/out from left)
class RailTransition extends StatefulWidget {
  const RailTransition({
    super.key,
    required this.animation,
    required this.backgroundColor,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;
  final Color backgroundColor;

  @override
  State<RailTransition> createState() => _RailTransitionState();
}

class _RailTransitionState extends State<RailTransition> {
  late Animation<Offset> offsetAnimation;
  late Animation<double> widthAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final bool ltr = Directionality.of(context) == TextDirection.ltr;

    widthAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: widget.animation,
      curve: NavigationAnimations.transitionCurve,
    ));

    offsetAnimation = Tween<Offset>(
      begin: ltr ? const Offset(-1, 0) : const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: widget.animation,
      curve: NavigationAnimations.transitionCurve,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          widthFactor: widthAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Animation for bottom bar transitions (slide in/out from bottom)
class BarTransition extends StatefulWidget {
  const BarTransition({
    super.key,
    required this.animation,
    required this.backgroundColor,
    required this.child,
  });

  final Animation<double> animation;
  final Color backgroundColor;
  final Widget child;

  @override
  State<BarTransition> createState() => _BarTransitionState();
}

class _BarTransitionState extends State<BarTransition> {
  late final Animation<Offset> offsetAnimation;
  late final Animation<double> heightAnimation;

  @override
  void initState() {
    super.initState();

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: widget.animation,
      curve: NavigationAnimations.transitionCurve,
    ));

    heightAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: widget.animation,
      curve: NavigationAnimations.transitionCurve,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: heightAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Smooth transition between navigation layouts
class NavigationLayoutTransition extends StatefulWidget {
  const NavigationLayoutTransition({
    super.key,
    required this.animationController,
    required this.railAnimation,
    required this.navigationRail,
    required this.navigationBar,
    required this.appBar,
    required this.body,
    required this.scaffoldKey,
  });

  final AnimationController animationController;
  final CurvedAnimation railAnimation;
  final Widget navigationRail;
  final Widget navigationBar;
  final PreferredSizeWidget appBar;
  final Widget body;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<NavigationLayoutTransition> createState() => _NavigationLayoutTransitionState();
}

class _NavigationLayoutTransitionState extends State<NavigationLayoutTransition> {
  late final ReverseAnimation barAnimation;

  @override
  void initState() {
    super.initState();

    barAnimation = ReverseAnimation(
      CurvedAnimation(
        parent: widget.animationController,
        curve: const Interval(0.0, 0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: widget.scaffoldKey,
      appBar: widget.appBar,
      body: Row(
        children: [
          RailTransition(
            animation: widget.railAnimation,
            backgroundColor: colorScheme.surface,
            child: widget.navigationRail,
          ),
          Expanded(child: widget.body),
        ],
      ),
      bottomNavigationBar: BarTransition(
        animation: barAnimation,
        backgroundColor: colorScheme.surface,
        child: widget.navigationBar,
      ),
    );
  }
}

/// Animation for page content transitions
class ContentTransition extends StatelessWidget {
  const ContentTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: NavigationAnimations.transitionCurve,
        )),
        child: child,
      ),
    );
  }
}