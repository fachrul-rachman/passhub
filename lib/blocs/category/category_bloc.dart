import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:passhub/models/category_form_model.dart';
import 'package:passhub/models/category_model.dart';
import 'package:passhub/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is CategoryGet) {
        try {
          emit(CategoryLoading());

          final category = await CategoryRepository().getCategory();

          emit(CategorySuccess(category));
        } catch (e) {
          emit(CategoryFailed(e.toString()));
        }
      }
      if (event is CategoryCreate) {
        try {
          emit(CategoryLoading());
          print('Sending Category Data: ${event.data.toJson()}');
          await CategoryRepository().createCategory(event.data);
          final createdCategory = await CategoryRepository().getCategory();
          print('Created Category: ${createdCategory.toString()}');
          emit(CategorySuccess(createdCategory));
        } catch (e) {
          print('Category Create Error: $e');
          emit(CategoryFailed(e.toString()));
        }
      }
    });
  }
}
