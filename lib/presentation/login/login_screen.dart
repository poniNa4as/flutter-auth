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

  bool _obscure = true;

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
    backgroundColor: const Color(0xFFF5F5F5),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.go('/home', extra: state.email);
            } else if (state.error.isNotEmpty &&
                state.errorId != _lastErrorId) {
              _lastErrorId = state.errorId;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Wrong email or password')),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 8),
                    )
                  ],
                ),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        focusNode: _emailFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: const OutlineInputBorder(),
                          errorText: _emailTouched && !state.isEmailValid
                              ? 'Invalid email'
                              : null,
                        ),
                        onChanged: cubit.emailChanged,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        focusNode: _passwordFocusNode,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          errorText: _passwordTouched && !state.isPasswordValid
                              ? 'Password too short'
                              : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          ),
                        ),
                        onChanged: cubit.passwordChanged,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: state.isValid && !state.isLoading
                              ? cubit.submit
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
  }
}
