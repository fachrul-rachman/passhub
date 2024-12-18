import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/blocs/category/category_bloc.dart';
import 'package:passhub/blocs/password/password_bloc.dart';
import 'package:passhub/models/category_model.dart';
import 'package:passhub/models/password_form_model.dart';
import 'package:passhub/shared/shared_methods.dart';
import 'package:passhub/shared/themed.dart';
import 'package:passhub/ui/widgets/buttons.dart';
import 'package:passhub/ui/widgets/forms.dart';

class MakeOwnPassPage extends StatefulWidget {
  const MakeOwnPassPage({super.key});

  @override
  State<MakeOwnPassPage> createState() => _MakeOwnPassPageState();
}

class _MakeOwnPassPageState extends State<MakeOwnPassPage> {
  CategoryModel? selectedCategory;

  TextEditingController _brandController = TextEditingController();
  TextEditingController platformController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _brandLogoUrl = '';
  bool test = true;

  void _updateBrandLogo() {
    String brandName = _brandController.text.trim();
    if (brandName.isNotEmpty) {
      setState(() {
        _brandLogoUrl = 'https://logo.clearbit.com/$brandName.com';
      });
    } else {
      setState(() {
        _brandLogoUrl = ''; // Reset if no brand is entered
      });
    }
  }

  @override
  void dispose() {
    _brandController.dispose();
    super.dispose();
  }

  bool validate() {
    bool isPlatformEmpty = _brandController.text.isEmpty;
    bool isEmailEmpty = emailController.text.isEmpty;
    bool isPasswordEmpty = passwordController.text.isEmpty;
    bool isCategoryNull = selectedCategory == null;

    if (isPlatformEmpty || isEmailEmpty || isPasswordEmpty || isCategoryNull) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _brandController.addListener(_updateBrandLogo);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blueDarkColor,
        body: BlocConsumer<PasswordBloc, PasswordState>(
          listener: (context, state) {
            if (state is PasswordFailed) {
              print(state.e);
              showCustomSnackbar(context, state.e);
            }
            if (state is PasswordCreateSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/add_pass_success', (route) => false);
            }
          },
          builder: (context, state) {
            if (state is PasswordLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: redColor,
                ),
              );
            }
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Make Your',
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
                  height: 30.h,
                ),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: greenColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 97.h,
                        width: 97.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          color: Colors.white54,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.h),
                          child: _brandLogoUrl.isNotEmpty
                              ? Image.network(
                                  _brandLogoUrl,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/logodummy.png',
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/logodummy.png',
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
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
                      CustomFormField(
                        title: 'Platform',
                        isShowTitle: false,
                        controller: _brandController,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomFormField(
                        title: 'Account Id',
                        isShowTitle: false,
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomFormField(
                        title: 'Password',
                        isShowTitle: false,
                        obscureText: true,
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocConsumer<CategoryBloc, CategoryState>(
                        listener: (context, state) {
                          if (state is CategoryFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Failed to load categories: ${state.e}')),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is CategoryLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is CategorySuccess) {
                            final categories = state.category;
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: blueDarkColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: DropdownButton<CategoryModel>(
                                  iconEnabledColor: blueDarkColor,
                                  dropdownColor: greenColor,
                                  isExpanded: true,
                                  hint: Text('Select Category'),
                                  value: selectedCategory,
                                  items: categories.map((category) {
                                    return DropdownMenuItem<CategoryModel>(
                                      value: category,
                                      child: Text(
                                          category.categoryName ?? 'Unknown'),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategory = value;
                                    });
                                  },
                                ),
                              ),
                            );
                          }
                          return Text('No Data');
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomFilledButton(
                        title: 'Add Password',
                        onPressed: () {
                          if (validate()) {
                            final formModel = PasswordFormModel(
                              generate: false,
                              platform: _brandController.text,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              categoryId: selectedCategory?.id,
                              imgPlatform: _brandLogoUrl.isNotEmpty
                                  ? _brandLogoUrl.trim()
                                  : 'https://logo.clearbit.com/google.com',
                            );

                            context
                                .read<PasswordBloc>()
                                .add(PasswordCreate(formModel));
                          } else {
                            showCustomSnackbar(
                                context, 'semua Field Harus di isi');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
