part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryGet extends CategoryEvent {}

class CategoryCreate extends CategoryEvent {
  final CategoryFormModel data;
  const CategoryCreate(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
