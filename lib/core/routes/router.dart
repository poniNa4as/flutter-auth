
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../presentation/login/login_screen.dart';
import '../../presentation/home/home_screen.dart';

final _storage = const FlutterSecureStorage();

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final token = await _storage.read(key: 'token');
    final isAuth = token != null;
    final isLoggingIn = state.uri.toString() == '/';

    if (!isAuth && !isLoggingIn) return '/';
    if (isAuth && isLoggingIn) return '/home';
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state)  {
        final email = state.extra as String;
        return HomeScreen(email: email);
      }
    ),
  ],
);
