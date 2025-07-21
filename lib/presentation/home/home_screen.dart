import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutUseCase = GetIt.I<LogoutUseCase>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome, test@test.com'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await logoutUseCase();
                context.go('/');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
