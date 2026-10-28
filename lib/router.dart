import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_state.dart';
import 'screens/book_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/date_picker_screen.dart';
import 'screens/error_screen.dart';
import 'screens/login_screen.dart';
import 'screens/my_books_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/reserve_screen.dart';
import 'screens/shell_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _catalogNavigatorKey = GlobalKey<NavigatorState>();
final _myBooksNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/catalog',
  refreshListenable: appState,
  debugLogDiagnostics: true,

  redirect: (context, state) {
    final path = state.uri.path;

    final isLogin = path == '/login';

    final isReserve = RegExp(
      r'^/catalog/book/[^/]+/reserve$',
    ).hasMatch(path);

    if (!appState.loggedIn && isReserve) {
      final from = Uri.encodeComponent(
        state.uri.toString(),
      );

      return '/login?from=$from';
    }

    if (appState.loggedIn && isLogin) {
      final from = state.uri.queryParameters['from'];

      return from ?? '/catalog';
    }

    return null;
  },

  errorBuilder: (context, state) {
    return ErrorScreen(
      message: state.error?.toString() ??
          'Невідома адреса: ${state.uri}',
    );
  },

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellScreen(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _catalogNavigatorKey,
          routes: [
            GoRoute(
              path: '/catalog',
              builder: (context, state) {
                return CatalogScreen(
                  genre: state.uri.queryParameters['genre'],
                );
              },
              routes: [
                GoRoute(
                  path: 'book/:bookId',
                  builder: (context, state) {
                    return BookScreen(
                      bookId: state.pathParameters['bookId']!,
                    );
                  },
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'reserve',
                      builder: (context, state) {
                        return ReserveScreen(
                          bookId: state.pathParameters['bookId']!,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _myBooksNavigatorKey,
          routes: [
            GoRoute(
              path: '/my-books',
              builder: (context, state) {
                return const MyBooksScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) {
                return const ProfileScreen();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      builder: (context, state) {
        return LoginScreen(
          from: state.uri.queryParameters['from'],
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/return-date',
      builder: (context, state) {
        return const DatePickerScreen();
      },
    ),
  ],
);