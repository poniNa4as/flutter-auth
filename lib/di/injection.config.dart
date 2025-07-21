// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth_clean_arch/data/repositories_impl/auth_repository_impl.dart'
    as _i128;
import 'package:auth_clean_arch/di/register_module.dart' as _i530;
import 'package:auth_clean_arch/domain/repositories/auth_repository.dart'
    as _i515;
import 'package:auth_clean_arch/domain/usecases/login_usecase.dart' as _i247;
import 'package:auth_clean_arch/domain/usecases/logout_usecase.dart' as _i163;
import 'package:auth_clean_arch/presentation/login/cubit/login_cubit.dart'
    as _i904;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => registerModule.storage);
    gh.lazySingleton<_i515.AuthRepository>(
        () => _i128.AuthRepositoryImpl(gh<_i558.FlutterSecureStorage>()));
    gh.factory<_i247.LoginUseCase>(
        () => _i247.LoginUseCase(gh<_i515.AuthRepository>()));
    gh.factory<_i163.LogoutUseCase>(
        () => _i163.LogoutUseCase(gh<_i515.AuthRepository>()));
    gh.factory<_i904.LoginCubit>(
        () => _i904.LoginCubit(gh<_i247.LoginUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i530.RegisterModule {}
