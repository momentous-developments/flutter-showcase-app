import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/providers/theme_provider.dart';
import 'core/theme/app_theme.dart';

/// The main application widget that configures Material 3 theming
/// and routing for the Flutter demo app.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme state changes
    final themeState = ref.watch(themeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Material 3 Demo',
      debugShowCheckedModeBanner: false,
      
      // Routing configuration
      routerConfig: router,
      
      // Theme configuration
      theme: AppTheme.light(
        colorSeed: themeState.colorSeed,
      ),
      darkTheme: AppTheme.dark(
        colorSeed: themeState.colorSeed,
      ),
      themeMode: themeState.themeMode,
      
      // Theme animation
      themeAnimationDuration: const Duration(milliseconds: 300),
      themeAnimationCurve: Curves.easeInOut,
    );
  }
}