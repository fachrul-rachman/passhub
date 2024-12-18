part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<CategoryModel> category;
  const CategorySuccess(this.category);

  @override
  // TODO: implement props
  List<Object> get props => [category];
}

final class CategoryFailed extends CategoryState {
  final String e;
  const CategoryFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

final class CategoryCreateSuccess extends CategoryState {
  final CategoryModel category;
  const CategoryCreateSuccess(this.category);

  @override
  // TODO: implement props
  List<Object> get props => [category];
}
