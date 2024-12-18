import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passhub/blocs/category/category_bloc.dart';
import 'package:passhub/blocs/password/password_bloc.dart';
import 'package:passhub/models/category_model.dart';
import 'package:passhub/models/password_model.dart';
import 'package:passhub/shared/themed.dart';
import 'package:passhub/ui/widgets/home_card_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/ui/widgets/home_category_item.dart';
import 'package:quickalert/quickalert.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryModel? selectedCategory;
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
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 40.h,
          ),
          children: [
            Text(
              'Keep Your',
              style: greenTextStyle.copyWith(
                fontSize: 36.sp,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Password',
                    style: redTextStyle.copyWith(
                      fontSize: 36.sp,
                      fontWeight: bold,
                    ),
                  ),
                  TextSpan(
                    text: ' Safe',
                    style: greenTextStyle.copyWith(
                      fontSize: 36.sp,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                print('Current Category State: $state');
                if (state is CategorySuccess) {
                  final allCategory =
                      CategoryModel(id: -1, categoryName: 'All');
                  final categories = [allCategory, ...state.category];

                  if (selectedCategory == null) {
                    selectedCategory = allCategory;
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((categoryModel) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = categoryModel;
                            });
                          },
                          child: HomeCategoryItem(
                            categoryModel: categoryModel,
                            isSelected:
                                categoryModel.id == selectedCategory?.id,
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }

                if (state is CategoryFailed) {
                  print(state.e);
                  return Center(
                    child: Text(state.e),
                  );
                }
                return Center(
                  child: Text(
                    'Loading Category...',
                    style: redTextStyle,
                  ),
                );
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            BlocProvider(
              create: (context) => PasswordBloc()..add(PasswordGet()),
              child: BlocBuilder<PasswordBloc, PasswordState>(
                builder: (context, state) {
                  if (state is PasswordSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${state.password.length} ',
                                style: greenTextStyle.copyWith(
                                  fontSize: 36.sp,
                                  fontWeight: bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Password',
                                style: redTextStyle.copyWith(
                                  fontSize: 24.sp,
                                  fontWeight: medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Column(
                          children: state.password.asMap().entries.map((entry) {
                            int index = entry.key;
                            PasswordModel passwordModel = entry.value;
                            return HomeCardItem(
                                passwordModel: passwordModel, index: index);
                          }).toList(),
                        ),
                      ],
                    );
                  }

                  if (state is PasswordFailed) {
                    print('selected Category is $selectedCategory');
                    return Center(
                      child: Text(state.e),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: redColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        backgroundColor: blueDarkColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: greenColor,
              context: context,
              builder: (BuildContext context) {
                return Wrap(
                  children: [
                    ListTile(
                      leading: Icon(Icons.security),
                      title: Text(
                        'Make Strong Password',
                        style: blueTextStyle.copyWith(
                            fontSize: 15, fontWeight: bold),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/add_pass');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.create),
                      title: Text(
                        'Make Own Password',
                        style: blueTextStyle.copyWith(
                            fontSize: 15, fontWeight: bold),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/make-pass');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.library_add_rounded),
                      title: Text(
                        'Add Category',
                        style: blueTextStyle.copyWith(
                            fontSize: 15, fontWeight: bold),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/add_category');
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(
            Icons.add,
            color: greenColor,
          ),
          backgroundColor: redColor,
        ),
      ),
    );
  }
}
