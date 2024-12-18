import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/blocs/auth/auth_bloc.dart';
import 'package:passhub/models/sign_in_form_model.dart';
import 'package:passhub/shared/shared_methods.dart';
import 'package:passhub/shared/themed.dart';
import 'package:passhub/ui/widgets/buttons.dart';
import 'package:passhub/ui/widgets/forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController(text: '');
  final pinController = TextEditingController(text: '');

  bool validate() {
    if (usernameController.text.isEmpty || pinController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              children: [
                Container(
                  width: 155.w,
                  height: 100.h,
                  margin: EdgeInsets.only(
                    top: 50.h,
                    bottom: 50.h,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/logodummy.png',
                      ),
                    ),
                  ),
                ),
                Text(
                  'Sign In & Protect\nYour Passwords',
                  style: greenTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        controller: usernameController,
                        title: 'Username',
                        isShowTitle: false,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomFormField(
                        controller: pinController,
                        title: 'pin',
                        isShowTitle: false,
                        isPin: true,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password',
                          style: redTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomFilledButton(
                        title: 'Sign In',
                        onPressed: () {
                          if (validate()) {
                            context.read<AuthBloc>().add(
                                  AuthLogin(
                                    SignInFormModel(
                                      username: usernameController.text,
                                      pin: pinController.text,
                                    ),
                                  ),
                                );
                          } else {
                            showCustomSnackbar(
                                context, 'Semua field harus di isi');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomTextButton(
                  title: "Create New Account",
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign-up');
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
