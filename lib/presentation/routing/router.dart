import 'package:go_router/go_router.dart';
import '../pages/landing_page.dart';
import '../pages/trails_page.dart';
import '../pages/login_page.dart';
import '../widgets/main_layout.dart';
import 'web_transitions.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => WebTransitions.fade(
            context: context,
            state: state,
            child: const LandingPage(),
          ),
        ),
        GoRoute(
          path: '/trails',
          pageBuilder: (context, state) => WebTransitions.fade(
            context: context,
            state: state,
            child: const TrailsPage(),
          ),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => WebTransitions.fade(
            context: context,
            state: state,
            child: const LoginPage(),
          ),
        ),
      ],
    ),
  ],
);
