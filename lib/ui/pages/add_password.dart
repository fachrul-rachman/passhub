import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passhub/blocs/category/category_bloc.dart';
import 'package:passhub/blocs/password/password_bloc.dart';
import 'package:passhub/models/category_model.dart';
import 'package:passhub/models/password_form_model.dart';
import 'package:passhub/shared/shared_methods.dart';
import 'package:passhub/shared/themed.dart';
import 'package:passhub/ui/widgets/add_features_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/ui/widgets/forms.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({super.key});

  @override
  State<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  int selectedNumber = 0;
  int selectedUpper = 0;
  int selectedSymbol = 0;
  CategoryModel? selectedCategory;

  TextEditingController _brandController = TextEditingController();
  TextEditingController platformController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String _brandLogoUrl = '';
  int charCount = 8;
  bool isExpanded = false;
  bool _hasExpanded = false;
  double opacity = 1.0;

  void _toggleContainer() {
    setState(() {
      isExpanded = !isExpanded;
      opacity = isExpanded ? 0.4 : 1;
      _hasExpanded = isExpanded;
      _brandController.addListener(_updateBrandLogo);
    });
  }

  void _updateBrandLogo() {
    String brandName = _brandController.text.trim();
    if (brandName.isNotEmpty) {
      setState(() {
        _brandLogoUrl = 'https://logo.clearbit.com/$brandName.com';
      });
    } else {
      setState(() {
        _brandLogoUrl = '';
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
    bool isCategoryNull = selectedCategory == null;

    if (isPlatformEmpty || isEmailEmpty || isCategoryNull) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordBloc, PasswordState>(
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
        return Scaffold(
          backgroundColor: blueDarkColor,
          body: Stack(
            children: [
              ListView(
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: opacity,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Create a ',
                                  style: greenTextStyle.copyWith(
                                    fontSize: 36.sp,
                                    fontWeight: medium,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Strong',
                                  style: redTextStyle.copyWith(
                                    fontSize: 36.sp,
                                    fontWeight: bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Password',
                            style: greenTextStyle.copyWith(
                              fontSize: 36.sp,
                              fontWeight: medium,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(14.w),
                              color: greenColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Features',
                                  style: blueTextStyle.copyWith(
                                    fontSize: 24.sp,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                SizedBox(
                                  height: 23.h,
                                ),
                                AddFeaturesItem(
                                  category: 'Numbers ',
                                  subtitle: '0 - 9',
                                  initialValue: selectedNumber,
                                  onNumberChange: (value) {
                                    setState(() {
                                      setState(() {
                                        selectedNumber = value;
                                      });
                                    });
                                  },
                                ),
                                AddFeaturesItem(
                                    category: 'Uppercases ',
                                    subtitle: 'A-Z',
                                    initialValue: selectedUpper,
                                    onNumberChange: (value) {
                                      setState(() {
                                        setState(() {
                                          selectedUpper = value;
                                        });
                                      });
                                    }),
                                AddFeaturesItem(
                                    category: 'Symbols ',
                                    subtitle: '!@#',
                                    initialValue: selectedSymbol,
                                    onNumberChange: (value) {
                                      setState(() {
                                        setState(() {
                                          selectedSymbol = value;
                                        });
                                      });
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Column(
                            children: [
                              Text(
                                'Characters',
                                style: greenTextStyle.copyWith(
                                  fontSize: 22.sp,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                charCount.toString(),
                                style: greenTextStyle.copyWith(
                                  fontSize: 25.sp,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Slider(
                                value: charCount.toDouble(),
                                min: 8,
                                max: 15,
                                activeColor: redColor,
                                inactiveColor: greenColor,
                                onChanged: (value) {
                                  setState(() {
                                    charCount = value.toInt();
                                    print(charCount);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 47.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeOutCubic,
                  height: isExpanded ? 550.h : 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: 30.h,
                      horizontal: 42.w,
                    ),
                    child: Column(
                      children: [
                        if (!_hasExpanded) ...[
                          Text(
                            'Generated Password',
                            style: blueTextStyle.copyWith(
                              fontSize: 20.sp,
                              fontWeight: regular,
                            ),
                          ),
                          SizedBox(
                            height: 19.h,
                          ),
                          Text(
                            'ztsqMxnl23',
                            style: redTextStyle.copyWith(
                              fontSize: 26.sp,
                              fontWeight: bold,
                            ),
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/home');
                                },
                                child: Image.asset(
                                  'assets/before.png',
                                  width: 27.w,
                                  color: blueDarkColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/reload.png',
                                  width: 27.w,
                                  color: blueDarkColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _toggleContainer();
                                },
                                child: Image.asset(
                                  'assets/next.png',
                                  width: 27.w,
                                  color: blueDarkColor,
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          Column(
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
                                  child: Image.network(
                                    _brandLogoUrl,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/logodummy.png',
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Generated Password',
                            style: blueTextStyle.copyWith(
                              fontSize: 20.sp,
                              fontWeight: regular,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'ztsqMxnl23',
                            style: redTextStyle.copyWith(
                              fontSize: 26.sp,
                              fontWeight: bold,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomFormField(
                            isShowTitle: false,
                            title: 'Platform',
                            controller: _brandController,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomFormField(
                            isShowTitle: false,
                            title: 'Service ID',
                            controller: emailController,
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
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: DropdownButton<CategoryModel>(
                                      iconEnabledColor: blueDarkColor,
                                      dropdownColor: greenColor,
                                      isExpanded: true,
                                      hint: Text('Select Category'),
                                      value: selectedCategory,
                                      items: categories.map((category) {
                                        return DropdownMenuItem<CategoryModel>(
                                          value: category,
                                          child: Text(category.categoryName ??
                                              'Unknown'),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _toggleContainer();
                                },
                                child: Image.asset(
                                  'assets/before.png',
                                  width: 30.w,
                                  color: redColor,
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (validate()) {
                                    final formModel = PasswordFormModel(
                                      generate: true,
                                      length: charCount,
                                      uppercase: selectedUpper,
                                      number: selectedNumber,
                                      symbol: selectedSymbol,
                                      platform: _brandController.text.trim(),
                                      email: emailController.text.trim(),
                                      categoryId: selectedCategory?.id,
                                      imgPlatform: _brandLogoUrl.isNotEmpty &&
                                              _brandLogoUrl !=
                                                  'https://logo.clearbit.com/${_brandController.text.trim()}.com'
                                          ? _brandLogoUrl.trim()
                                          : 'assets/logodummy.png',
                                    );

                                    context
                                        .read<PasswordBloc>()
                                        .add(PasswordCreate(formModel));
                                  } else {
                                    showCustomSnackbar(
                                        context, 'semua Field Harus di isi');
                                  }
                                },
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 45.w,
                                  color: blueDarkColor,
                                ),
                              ),
                              SizedBox(
                                height: 22.h,
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
