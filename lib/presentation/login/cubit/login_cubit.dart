import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginState.initial());

  void emailChanged(String value) => emit(state.copyWith(email: value));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: value));

  Future<void> submit() async {
    if (!state.isValid) return;

    emit(state.copyWith(isLoading: true, error: ''));

    try {
      await _loginUseCase(state.email, state.password);
      emit(state.copyWith(isSuccess: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
