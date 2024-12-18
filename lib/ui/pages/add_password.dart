import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/blocs/category/category_bloc.dart';
import 'package:passhub/blocs/password/password_bloc.dart';
import 'package:passhub/models/category_model.dart';
import 'package:passhub/models/password_form_model.dart';
import 'package:passhub/shared/shared_methods.dart';
import 'package:passhub/shared/themed.dart';
import 'package:passhub/ui/widgets/add_features_item.dart';
import 'package:passhub/ui/widgets/buttons.dart';
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
  int charCount = 8;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: blueDarkColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Create a',
                      style: greenTextStyle.copyWith(
                          fontSize: 30.sp, fontWeight: medium),
                    ),
                    TextSpan(
                      text: ' Strong',
                      style: redTextStyle.copyWith(
                          fontSize: 30.sp, fontWeight: bold),
                    )
                  ],
                ),
              ),
              Text(
                'Password',
                style: greenTextStyle.copyWith(
                    fontSize: 30.sp, fontWeight: medium),
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
                  borderRadius: BorderRadius.circular(14.r),
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
                        fontSize: 18.sp,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AddFeaturesItem(
                        category: 'Number ',
                        subtitle: '0 - 9',
                        initialValue: selectedNumber,
                        onNumberChange: (value) {
                          setState(() {
                            selectedNumber = value;
                          });
                        }),
                    AddFeaturesItem(
                        category: 'Uppercases ',
                        subtitle: 'A - Z',
                        initialValue: selectedUpper,
                        onNumberChange: (value) {
                          setState(() {
                            selectedUpper = value;
                          });
                        }),
                    AddFeaturesItem(
                        category: 'Symbol ',
                        subtitle: '!@#',
                        initialValue: selectedSymbol,
                        onNumberChange: (value) {
                          setState(() {
                            selectedSymbol = value;
                          });
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Characters',
                      style: greenTextStyle.copyWith(
                          fontSize: 25.sp, fontWeight: bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      charCount.toString(),
                      style: redTextStyle.copyWith(
                        fontSize: 25.sp,
                        fontWeight: bold,
                      ),
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
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Generated Password',
                      style: greenTextStyle.copyWith(fontSize: 20.sp),
                    ),
                    Text(
                      'ztsqMxnl23',
                      style: redTextStyle.copyWith(
                          fontSize: 23.sp, fontWeight: bold),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CustomFilledButton(
                      title: 'Make Password',
                      onPressed: () {
                        showPopUp(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void showPopUp(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: PopupContainer(
              selectedNumber: selectedNumber,
              selectedUpper: selectedUpper,
              selectedSymbol: selectedSymbol,
              charCount: charCount),
        );
      },
    );
  }
}

class PopupContainer extends StatefulWidget {
  final int selectedNumber;
  final int selectedUpper;
  final int selectedSymbol;
  final int charCount;
  const PopupContainer({
    required this.selectedNumber,
    required this.selectedUpper,
    required this.selectedSymbol,
    required this.charCount,
    super.key,
  });

  @override
  State<PopupContainer> createState() => _PopupContainerState();
}

class _PopupContainerState extends State<PopupContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  CategoryModel? selectedCategory;
  TextEditingController brandController = TextEditingController();
  TextEditingController platformController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String brandLogoUrl = '';

  void _updateBrandLogo() {
    String brandName = brandController.text.trim();
    if (brandName.isNotEmpty) {
      setState(() {
        brandLogoUrl = 'https://logo.clearbit.com/$brandName.com';
      });
    } else {
      setState(() {
        brandLogoUrl = '';
      });
    }
  }

  bool validate() {
    bool isPlatformEmpty = brandController.text.isEmpty;
    bool isEmailEmpty = emailController.text.isEmpty;
    bool isCategoryNull = selectedCategory == null;

    if (isPlatformEmpty || isEmailEmpty || isCategoryNull) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    brandController.addListener(_updateBrandLogo);
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceOut,
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
        return ScaleTransition(
          scale: animation,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: greenColor,
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: 71.h,
                              width: 71.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.network(
                                  brandLogoUrl,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset('assets/logodummy.png');
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: redColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              'Generated Password',
                              style: blueTextStyle.copyWith(fontSize: 16.sp),
                            ),
                            Text(
                              'ztsqMxnl23',
                              style: redTextStyle.copyWith(
                                  fontSize: 20.sp, fontWeight: bold),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomFormField(
                              isShowTitle: false,
                              title: 'Platform',
                              controller: brandController,
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
                                      padding: EdgeInsets.only(
                                          left: 10.r, right: 10.r),
                                      child: DropdownButton<CategoryModel>(
                                        iconEnabledColor: blueDarkColor,
                                        dropdownColor: greenColor,
                                        isExpanded: true,
                                        hint: Text('Select Category'),
                                        value: selectedCategory,
                                        items: categories.map((category) {
                                          return DropdownMenuItem<
                                              CategoryModel>(
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
                            CustomFilledButton(
                              title: 'Add Password',
                              onPressed: () {
                                if (validate()) {
                                  final formModel = PasswordFormModel(
                                    generate: true,
                                    length: widget.charCount,
                                    uppercase: widget.selectedUpper,
                                    number: widget.selectedNumber,
                                    symbol: widget.selectedSymbol,
                                    platform: brandController.text.trim(),
                                    email: emailController.text.trim(),
                                    categoryId: selectedCategory?.id,
                                    imgPlatform: brandLogoUrl.isNotEmpty &&
                                            brandLogoUrl !=
                                                'https://logo.clearbit.com/${brandController.text.trim()}.com'
                                        ? brandLogoUrl.trim()
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: redColor,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
