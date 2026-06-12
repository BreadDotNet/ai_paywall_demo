import 'package:go_router/go_router.dart';

import '../../features/app/application/bloc/app_session_cubit.dart';
import '../../features/app/presentation/page/not_found_page.dart';
import '../../features/home/presentation/page/home_page.dart';
import '../../features/onboarding/presentation/page/onboarding_page.dart';
import '../../features/paywall/presentation/page/paywall_page.dart';
import '../di/di_container.dart';
import 'app_routes.dart';

GoRouter createRouter(DIContainer container) {
  final session = container.get<AppSessionCubit>();
  final initialLocation = session.state.hasActiveEntitlement
      ? AppRoutes.homePath
      : AppRoutes.onboardingPath;

  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: AppRoutes.onboardingPath,
        name: AppRoutes.onboardingName,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.paywallPath,
        name: AppRoutes.paywallName,
        builder: (context, state) => const PaywallPage(),
      ),
      GoRoute(
        path: AppRoutes.homePath,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
