import 'package:demoproject/Utils/sharedPrefs.dart';
import 'package:demoproject/View/dashboard.view.dart';
import 'package:demoproject/View/login.view.dart';
import 'package:demoproject/View/repoInfo.view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: getInitialLocation(),
  routes: routesInformation,
);

String getInitialLocation() {
  return SharedPrefs.getLogginStatus() == 1 ? '/dashboard' : '/login';
}

List<RouteBase> get routesInformation {
  return [buildLoginRoute(), buildDashBoardRoute()];
}

GoRoute buildLoginRoute() {
  return GoRoute(
      path: '/login',
      routes: [],
      builder: (context, state) => const LoginScreen());
}

GoRoute buildDashBoardRoute() {
  return GoRoute(
    path: '/dashboard',
    builder: (context, state) => const DashboardView(),
  );
}
