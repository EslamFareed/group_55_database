part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


//! -------------------------------------------
class LoadingLoginState extends AuthState{}
class ErrorLoginState extends AuthState{}
class SuccessLoginState extends AuthState{}



//! -------------------------------------------
class LoadingCreateAccountState extends AuthState{}
class ErrorCreateAccountState extends AuthState{}
class SuccessCreateAccountState extends AuthState{}