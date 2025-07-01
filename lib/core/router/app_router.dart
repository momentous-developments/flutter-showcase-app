import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigation/app_navigation.dart';
import '../../features/dashboard/dashboard_page.dart';
import '../../features/components/components_page.dart';
import '../../features/components/cards/cards_showcase.dart';
import '../../features/components/dialogs/dialogs_showcase.dart';
import '../../features/components/buttons/buttons_showcase.dart';
import '../../features/components/navigation/navigation_showcase.dart';
import '../../features/components/inputs/inputs_showcase.dart';
import '../../features/forms/forms_page.dart';
import '../../features/tables/tables_page.dart';
import '../../modules/academy/academy_page.dart';
import '../../modules/academy/views/index.dart';
import '../../features/ecommerce/ecommerce_page.dart';
import '../../features/ecommerce/views/product_list.dart';
import '../../features/ecommerce/views/product_details.dart';
import '../../features/ecommerce/views/shopping_cart.dart';
import '../../features/chat/simple_chat_page.dart';
import '../../features/kanban/kanban_page.dart';
import '../../features/charts/charts_page.dart';
import '../../features/calendar/calendar_page.dart';
import '../../features/modules/modules_overview_page.dart';
import '../../modules/invoice/invoice_page.dart';
import '../../modules/logistics/logistics_page.dart';
import '../../modules/email/email_page.dart';
import '../../features/settings/settings_page.dart';

// Import page templates
import '../../features/auth/index.dart';
import '../../features/account/index.dart';
import '../../features/marketing/index.dart';
import '../../features/misc/index.dart';

/// Provider for the app router
final appRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter.router;
});

/// Manages application routing and navigation
class AppRouter {
  AppRouter._();

  /// Router configuration
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Main shell route with app navigation
      ShellRoute(
        builder: (context, state, child) {
          return AppNavigation(child: child);
        },
        routes: [
          // Dashboard route
          GoRoute(
            path: '/',
            name: 'dashboard',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const DashboardPage(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          
          // Components showcase
          GoRoute(
            path: '/components',
            name: 'components',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ComponentsPage(),
              transitionsBuilder: _fadeTransition,
            ),
            routes: [
              GoRoute(
                path: '/cards',
                name: 'cards',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const CardsShowcase(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/dialogs',
                name: 'dialogs',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const DialogsShowcase(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/forms',
                name: 'forms',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const FormsPage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/tables',
                name: 'tables',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const TablesPage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/charts',
                name: 'charts',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const ChartsPage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/buttons',
                name: 'buttons',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const ButtonsShowcase(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/navigation',
                name: 'navigation-components',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const NavigationShowcase(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/inputs',
                name: 'inputs',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const InputsShowcase(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
            ],
          ),
          
          // Modules
          GoRoute(
            path: '/modules',
            name: 'modules',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ModulesOverviewPage(),
              transitionsBuilder: _fadeTransition,
            ),
            routes: [
              GoRoute(
                path: '/academy',
                name: 'academy',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const AcademyPage(),
                  transitionsBuilder: _slideTransition,
                ),
                routes: [
                  GoRoute(
                    path: '/dashboard',
                    name: 'academy-dashboard',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const AcademyDashboardView(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/courses',
                    name: 'academy-courses',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const CourseListView(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/course-details/:courseId',
                    name: 'academy-course-details',
                    pageBuilder: (context, state) {
                      final courseId = int.parse(state.pathParameters['courseId']!);
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: CourseDetailsView(courseId: courseId),
                        transitionsBuilder: _slideTransition,
                      );
                    },
                  ),
                  GoRoute(
                    path: '/progress',
                    name: 'academy-progress',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const StudentProgressView(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/instructors',
                    name: 'academy-instructors',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const InstructorManagementView(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: '/ecommerce',
                name: 'ecommerce',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const EcommercePage(),
                  transitionsBuilder: _slideTransition,
                ),
                routes: [
                  GoRoute(
                    path: '/products',
                    name: 'ecommerce-products',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ProductListView(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/product/:productId',
                    name: 'ecommerce-product-details',
                    pageBuilder: (context, state) {
                      final productId = int.parse(state.pathParameters['productId']!);
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: ProductDetailsView(productId: productId),
                        transitionsBuilder: _slideTransition,
                      );
                    },
                  ),
                  GoRoute(
                    path: '/cart',
                    name: 'ecommerce-cart',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ShoppingCartView(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/checkout',
                    name: 'ecommerce-checkout',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const _PlaceholderScreen(title: 'Checkout'),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/orders',
                    name: 'ecommerce-orders',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const _PlaceholderScreen(title: 'Order Management'),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/wishlist',
                    name: 'ecommerce-wishlist',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const _PlaceholderScreen(title: 'Wishlist'),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/reviews',
                    name: 'ecommerce-reviews',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const _PlaceholderScreen(title: 'Customer Reviews'),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/admin',
                    name: 'ecommerce-admin',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const _PlaceholderScreen(title: 'Admin Dashboard'),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: '/email',
                name: 'email',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const EmailPage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/chat',
                name: 'chat',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const SimpleChatPage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/calendar',
                name: 'calendar',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const CalendarPage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/kanban',
                name: 'kanban',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const KanbanPage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/invoice',
                name: 'invoice',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const InvoicePage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
              GoRoute(
                path: '/logistics',
                name: 'logistics',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const LogisticsPage(),
                  transitionsBuilder: _slideTransition,
                ),
              ),
            ],
          ),
          
          // Pages
          GoRoute(
            path: '/pages',
            name: 'pages',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const _PlaceholderScreen(title: 'Pages'),
              transitionsBuilder: _fadeTransition,
            ),
            routes: [
              // Authentication Pages
              GoRoute(
                path: '/auth',
                name: 'auth-pages',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const _PlaceholderScreen(title: 'Authentication Pages'),
                  transitionsBuilder: _slideTransition,
                ),
                routes: [
                  GoRoute(
                    path: '/login',
                    name: 'auth-login',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const LoginPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/register',
                    name: 'auth-register',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const RegisterPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/forgot-password',
                    name: 'auth-forgot-password',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ForgotPasswordPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/reset-password',
                    name: 'auth-reset-password',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: ResetPasswordPage(token: state.uri.queryParameters['token']),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/two-factor',
                    name: 'auth-two-factor',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const TwoFactorAuthPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/email-verification',
                    name: 'auth-email-verification',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: EmailVerificationPage(email: state.uri.queryParameters['email']),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/welcome',
                    name: 'auth-welcome',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const WelcomePage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                ],
              ),
              // Account Pages
              GoRoute(
                path: '/account',
                name: 'account-pages',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const _PlaceholderScreen(title: 'Account Pages'),
                  transitionsBuilder: _slideTransition,
                ),
                routes: [
                  GoRoute(
                    path: '/profile',
                    name: 'account-profile',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ProfilePage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/settings',
                    name: 'account-settings',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const AccountSettingsPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/security',
                    name: 'account-security',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const SecuritySettingsPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/notifications',
                    name: 'account-notifications',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const NotificationSettingsPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/billing',
                    name: 'account-billing',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const BillingPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/api-keys',
                    name: 'account-api-keys',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ApiKeysPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/connected-accounts',
                    name: 'account-connected-accounts',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ConnectedAccountsPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                ],
              ),
              // Marketing Pages
              GoRoute(
                path: '/marketing',
                name: 'marketing-pages',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const _PlaceholderScreen(title: 'Marketing Pages'),
                  transitionsBuilder: _slideTransition,
                ),
                routes: [
                  GoRoute(
                    path: '/landing',
                    name: 'marketing-landing',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const LandingPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/pricing',
                    name: 'marketing-pricing',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const PricingPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/features',
                    name: 'marketing-features',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const FeaturesPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/contact',
                    name: 'marketing-contact',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ContactPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/about',
                    name: 'marketing-about',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const AboutPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/faq',
                    name: 'marketing-faq',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const FAQPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                ],
              ),
              // Miscellaneous Pages
              GoRoute(
                path: '/misc',
                name: 'misc-pages',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const _PlaceholderScreen(title: 'Miscellaneous Pages'),
                  transitionsBuilder: _slideTransition,
                ),
                routes: [
                  GoRoute(
                    path: '/not-found',
                    name: 'misc-not-found',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const NotFoundPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/server-error',
                    name: 'misc-server-error',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ServerErrorPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/maintenance',
                    name: 'misc-maintenance',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const MaintenancePage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                  GoRoute(
                    path: '/coming-soon',
                    name: 'misc-coming-soon',
                    pageBuilder: (context, state) => CustomTransitionPage(
                      key: state.pageKey,
                      child: const ComingSoonPage(),
                      transitionsBuilder: _slideTransition,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Settings
          GoRoute(
            path: '/settings',
            name: 'settings',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const SettingsPage(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
        ],
      ),
      
      // Auth routes (no base scaffold)
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const RegisterPage(),
          transitionsBuilder: _fadeTransition,
        ),
      ),
    ],
    errorPageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const NotFoundPage(),
      transitionsBuilder: _fadeTransition,
    ),
  );

  /// Fade transition animation
  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Slide transition animation
  static Widget _slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

/// Placeholder screen for routes that haven't been implemented yet
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({
    required this.title,
    this.showAppBar = true,
  });

  final String title;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            title.contains('Available') 
                ? 'Implementation exists but requires dependency fixes'
                : 'This page is under construction',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (title.contains('Forms')) ...[
            const SizedBox(height: 16),
            Text(
              'Features: Form Layouts, Form Elements, Validation, Templates',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          if (title.contains('Tables')) ...[
            const SizedBox(height: 16),
            Text(
              'Features: Sortable, Filterable, Paginated, Editable, Exportable',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          if (title.contains('Email')) ...[
            const SizedBox(height: 16),
            Text(
              'Features: Inbox, Compose, Contacts, Templates, Settings',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );

    if (!showAppBar) {
      return Scaffold(body: content);
    }

    return content;
  }
}

/// Error screen for 404 and other routing errors
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              '404',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Route guards for authentication
class AuthGuard {
  static String? redirectIfNotAuthenticated(
    BuildContext context,
    GoRouterState state,
  ) {
    // TODO: Implement actual authentication check
    // const isAuthenticated = true;
    // 
    // if (!isAuthenticated) {
    //   return '/login?redirect=${state.uri.toString()}';
    // }
    
    return null;
  }
  
  static String? redirectIfAuthenticated(
    BuildContext context,
    GoRouterState state,
  ) {
    // TODO: Implement actual authentication check
    // const isAuthenticated = false;
    // 
    // if (isAuthenticated) {
    //   final redirect = state.uri.queryParameters['redirect'];
    //   return redirect ?? '/';
    // }
    
    return null;
  }
}