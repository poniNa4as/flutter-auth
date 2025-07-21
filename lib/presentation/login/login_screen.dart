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

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  bool _emailTouched = false;
  bool _passwordTouched = false;

  int _lastErrorId = -1;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        setState(() => _emailTouched = true);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        setState(() => _passwordTouched = true);
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

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
              context.go('/home', extra: state.email);
            } else if (state.error.isNotEmpty && state.errorId != _lastErrorId) {
              _lastErrorId = state.errorId;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Wrong email or password')),
              );
            }
          },
          builder: (context, state) {
            return Form(
              child: Column(
                children: [
                  TextFormField(
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailTouched && !state.isEmailValid
                          ? 'Invalid email'
                          : null,
                    ),
                    onChanged: cubit.emailChanged,
                  ),
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordTouched && !state.isPasswordValid
                          ? 'Password too short'
                          : null,
                    ),
                    obscureText: true,
                    onChanged: cubit.passwordChanged,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state.isValid && !state.isLoading
                        ? cubit.submit
                        : null,
                    child: state.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
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

