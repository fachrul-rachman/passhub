part of 'password_bloc.dart';

sealed class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PasswordGet extends PasswordEvent {}

class PasswordCreate extends PasswordEvent {
  final PasswordFormModel data;
  const PasswordCreate(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class PasswordDelete extends PasswordEvent {
  final int id;
  const PasswordDelete(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class PasswordGetByCategory extends PasswordEvent {
  final int categoryId;
  const PasswordGetByCategory(this.categoryId);

  @override
  // TODO: implement props
  List<Object?> get props => [categoryId];
}
