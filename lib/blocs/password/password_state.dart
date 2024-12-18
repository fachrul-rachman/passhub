part of 'password_bloc.dart';

sealed class PasswordState extends Equatable {
  const PasswordState();
  @override
  List<Object> get props => [];
}

final class PasswordInitial extends PasswordState {}

final class PasswordLoading extends PasswordState {}

final class PasswordSuccess extends PasswordState {
  final List<PasswordModel> password;
  const PasswordSuccess(this.password);

  @override
  List<Object> get props => [password];
}

final class PasswordCreateSuccess extends PasswordState {
  final PasswordModel password;
  const PasswordCreateSuccess(this.password);

  @override
  List<Object> get props => [password];
}

final class PasswordFailed extends PasswordState {
  final String e;
  const PasswordFailed(this.e);

  @override
  List<Object> get props => [e];
}
