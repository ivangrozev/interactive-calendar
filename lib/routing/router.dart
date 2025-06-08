import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_calendar/auth/screens/login_screen.dart';
import 'package:interactive_calendar/auth/screens/register_screen.dart';
import 'package:interactive_calendar/data/repositories/auth/auth_repository_remote.dart';
import 'package:interactive_calendar/event/screens/add_event_screen.dart';
import 'package:interactive_calendar/event/viewmodels/event_viewmodel.dart';
import 'package:interactive_calendar/guest/guest_view.dart';
import 'package:interactive_calendar/home/viewmodels/home_viewmodel.dart';
import 'package:interactive_calendar/routing/Routes.dart';
import 'package:interactive_calendar/home/screens/home_page_screen.dart';
import 'package:interactive_calendar/ui/scaffold_with_bottom_navbar.dart';
import 'package:interactive_calendar/user/screens/user_profile_screen.dart';
import 'package:interactive_calendar/user/viewmodels/user_profile_viewmodel.dart';
import 'package:provider/provider.dart';

GoRouter router(BuildContext context) {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> sectionNavigatorKey =
      GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.home,
    refreshListenable: Provider.of<AuthRepositoryRemote>(context, listen: true),
    redirect: (context, state) {
      var isLoggedIn =
          Provider.of<AuthRepositoryRemote>(context, listen: false).isLogged;

      if (!isLoggedIn &&
          state.fullPath != Routes.login &&
          state.fullPath != Routes.register &&
          state.fullPath != Routes.seeEventsAsGuest) {
        return Routes.login;
      }
      if (isLoggedIn && state.fullPath == Routes.login) {
        return Routes.home;
      }
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithBottomNavbar(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(navigatorKey: sectionNavigatorKey, routes: [
              GoRoute(
                path: Routes.home,
                builder: (BuildContext context, GoRouterState state) {
                  final viewModel =
                      HomeViewModel(authRepository: context.read());
                  return HomePageScreen(viewModel: viewModel);
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: Routes.profile,
                builder: (BuildContext context, GoRouterState state) {
                  var viewModel =
                      UserProfileViewModel(repository: context.read());
                  return UserProfileScreen(
                      viewmodel: viewModel, auth: context.read());
                },
              ),
            ]),
          ]),
      GoRoute(
        path: Routes.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.seeEventsAsGuest,
        builder: (context, state) {
          return GuestView();
        },
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: Routes.addEvent,
        builder: (context, state) {
          final viewModel = EventViewModel(
              repository: context.read(), uiService: context.read());
          return AddEventScreen(null,
              viewmodel: viewModel);
        },
      ),
      GoRoute(
        path: Routes.editEvent,
        builder: (context, state) {
          var event = state.extra as Map<String, dynamic>;
          final viewModel = EventViewModel(repository: context.read(), uiService: context.read());
          return AddEventScreen(event,
              viewmodel: viewModel);
        },
      ),
    ],
  );
}
