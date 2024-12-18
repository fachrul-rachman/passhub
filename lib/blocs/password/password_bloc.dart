import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:passhub/blocs/category/category_bloc.dart';
import 'package:passhub/models/password_form_model.dart';
import 'package:passhub/models/password_model.dart';
import 'package:passhub/repositories/password_repository.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitial()) {
    on<PasswordEvent>((event, emit) async {
      if (event is PasswordGet) {
        try {
          emit(PasswordLoading());

          final password = await PasswordRepository().getPassword();

          emit(PasswordSuccess(password));
        } catch (e) {
          emit(PasswordFailed(e.toString()));
        }
      }

      if (event is PasswordCreate) {
        try {
          emit(PasswordLoading());
          final createdPassword =
              await PasswordRepository().createPassword(event.data);

          emit(PasswordCreateSuccess(createdPassword));
        } catch (e) {
          emit(PasswordFailed(e.toString()));
        }
      }

      if (event is PasswordDelete) {
        try {
          emit(PasswordLoading());
          await PasswordRepository().deletePassword(event.id);
          final updatedPassword = await PasswordRepository().getPassword();
          emit(PasswordSuccess(updatedPassword));
        } catch (e) {
          emit(PasswordFailed(e.toString()));
        }
      }

      if (event is PasswordGetByCategory) {
        try {
          emit(PasswordLoading());
          final List<PasswordModel> passwords;
          if (event.categoryId == -1) {
            passwords = await PasswordRepository().getPassword();
          } else {
            passwords = await PasswordRepository()
                .getPasswordByCategory(event.categoryId);
          }
          emit(PasswordSuccess(passwords));
        } catch (e) {
          emit(PasswordFailed(e.toString()));
        }
      }
    });
  }
}
