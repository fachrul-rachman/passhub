import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/blocs/auth/auth_bloc.dart';
import 'package:passhub/models/sign_up_form_model.dart';
import 'package:passhub/shared/shared_methods.dart';
import 'package:passhub/shared/themed.dart';
import 'package:passhub/ui/widgets/buttons.dart';
import 'package:passhub/ui/widgets/forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final pinController = TextEditingController();

  bool validate() {
    if (fullNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        pinController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueDarkColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: redColor,
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            children: [
              Container(
                width: 155.w,
                height: 50.h,
                margin: EdgeInsets.only(top: 100.h, bottom: 90.h),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logodummy.png'),
                  ),
                ),
              ),
              Text(
                'Join PassHub to\nSecure Your Digital Life',
                style: greenTextStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: greenColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      controller: fullNameController,
                      title: 'Full Name',
                      isShowTitle: false,
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      controller: usernameController,
                      title: 'Username',
                      isShowTitle: false,
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      controller: pinController,
                      title: 'Pin',
                      isShowTitle: false,
                      isPin: true,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    CustomFilledButton(
                      title: "Continue",
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthRegister(
                                  SignUpFormModel(
                                    fullName: fullNameController.text,
                                    username: usernameController.text,
                                    pin: pinController.text,
                                  ),
                                ),
                              );
                        } else {
                          showCustomSnackbar(
                              context, 'Semua field harus di isi!');
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                title: "Sign In",
              ),
              SizedBox(height: 30.h),
            ],
          );
        },
      ),
    );
  }
}
