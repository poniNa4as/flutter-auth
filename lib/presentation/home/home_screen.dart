import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final String? email;
  const HomeScreen({super.key, this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final LogoutUseCase logoutUseCase;

  void _navigateHome() {
    context.go('/');
  }

  @override
  void initState() {
    super.initState();
    logoutUseCase = GetIt.I<LogoutUseCase>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.home, size: 64, color: Colors.black54),
              const SizedBox(height: 16),
              Text(
                'Welcome, ${widget.email ?? 'User'}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await logoutUseCase();
                    if (!mounted) return;
                    _navigateHome();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
