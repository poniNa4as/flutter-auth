import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<LoginCubit>(),
      child: const LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.go('/home');
            } else if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: cubit.emailChanged,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: cubit.passwordChanged,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state.isValid && !state.isLoading
                        ? cubit.submit
                        : null,
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
