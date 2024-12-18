import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/blocs/category/category_bloc.dart';
import 'package:passhub/models/category_form_model.dart';
import 'package:passhub/shared/shared_methods.dart';
import 'package:passhub/shared/themed.dart';
import 'package:passhub/ui/widgets/buttons.dart';
import 'package:passhub/ui/widgets/updateForm.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController categoryController = TextEditingController();
  bool validate() {
    bool isCategoryEmpty = categoryController.text.isEmpty;
    if (isCategoryEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryFailed) {
          print(state.e.toString());
          showCustomSnackbar(context, state.e);
        }
        if (state is CategorySuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/add_category_success', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: redColor,
            ),
          );
        }
        return Scaffold(
          backgroundColor: blueDarkColor,
          body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Your',
                      style: greenTextStyle.copyWith(
                        fontSize: 36,
                        fontWeight: medium,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Own ',
                            style: redTextStyle.copyWith(
                              fontSize: 36,
                              fontWeight: bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Password',
                            style: greenTextStyle.copyWith(
                              fontSize: 36,
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: greenColor,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Make A Password',
                      style: blueTextStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomFormFieldUpdate(
                      controller: categoryController,
                      title: 'Category',
                      isShowTitle: false,
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    CustomFilledButton(
                      title: 'Add',
                      onPressed: () {
                        if (validate()) {
                          final formModel = CategoryFormModel(
                              categoryName: categoryController.text);
                          print(formModel.toJson());
                          context
                              .read<CategoryBloc>()
                              .add(CategoryCreate(formModel));
                        } else {
                          showCustomSnackbar(context, 'category harus di isi');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
