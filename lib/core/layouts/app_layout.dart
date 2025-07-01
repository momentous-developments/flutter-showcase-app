import 'package:flutter/material.dart';
import '../navigation/app_navigation.dart';

/// Main app layout with navigation wrapper
class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppNavigation(child: child);
  }
}

/// Layout with custom app bar and optional floating action button
class CustomAppLayout extends StatelessWidget {
  const CustomAppLayout({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.persistentFooterButtons,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final List<Widget>? persistentFooterButtons;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawer: drawer,
      endDrawer: endDrawer,
      persistentFooterButtons: persistentFooterButtons,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

/// Layout for full-width content (no navigation)
class FullWidthLayout extends StatelessWidget {
  const FullWidthLayout({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: child,
    );
  }
}

/// Layout with drawer navigation
class DrawerLayout extends StatelessWidget {
  const DrawerLayout({
    super.key,
    required this.body,
    required this.drawer,
    this.appBar,
    this.endDrawer,
    this.floatingActionButton,
  });

  final Widget body;
  final Widget drawer;
  final PreferredSizeWidget? appBar;
  final Widget? endDrawer;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

/// Layout with tab navigation
class TabLayout extends StatefulWidget {
  const TabLayout({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.appBar,
    this.initialIndex = 0,
    this.onTabChanged,
    this.isScrollable = false,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
  });

  final List<Tab> tabs;
  final List<Widget> tabViews;
  final PreferredSizeWidget? appBar;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;
  final bool isScrollable;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      widget.onTabChanged?.call(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ?? AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: widget.tabs,
          isScrollable: widget.isScrollable,
          indicatorColor: widget.indicatorColor,
          labelColor: widget.labelColor,
          unselectedLabelColor: widget.unselectedLabelColor,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.tabViews,
      ),
    );
  }
}

/// Layout with nested scrolling coordination
class NestedScrollLayout extends StatelessWidget {
  const NestedScrollLayout({
    super.key,
    required this.headerSliverBuilder,
    required this.body,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
  });

  final Widget Function(BuildContext context, bool innerBoxIsScrolled) headerSliverBuilder;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      body: NestedScrollView(
        headerSliverBuilder: headerSliverBuilder,
        body: body,
      ),
    );
  }
}

/// Layout with expandable content
class ExpandableLayout extends StatefulWidget {
  const ExpandableLayout({
    super.key,
    required this.header,
    required this.expandedContent,
    required this.collapsedContent,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.expandedHeight,
    this.collapsedHeight,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final Widget header;
  final Widget expandedContent;
  final Widget collapsedContent;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final double? expandedHeight;
  final double? collapsedHeight;
  final Duration animationDuration;

  @override
  State<ExpandableLayout> createState() => _ExpandableLayoutState();
}

class _ExpandableLayoutState extends State<ExpandableLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onExpansionChanged?.call(_isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggle,
          child: widget.header,
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: _animation.value,
                child: _isExpanded ? widget.expandedContent : widget.collapsedContent,
              ),
            );
          },
        ),
      ],
    );
  }
}