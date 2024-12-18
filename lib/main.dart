import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/blocs/auth/auth_bloc.dart';
import 'package:passhub/blocs/category/category_bloc.dart';
import 'package:passhub/blocs/password/password_bloc.dart';
import 'package:passhub/models/password_model.dart';
import 'package:passhub/ui/pages/add_category_page.dart';
import 'package:passhub/ui/pages/add_category_success.dart';
import 'package:passhub/ui/pages/add_password.dart';
import 'package:passhub/ui/pages/add_password_success.dart';
import 'package:passhub/ui/pages/delete_password_success_page.dart';
import 'package:passhub/ui/pages/home.dart';
import 'package:passhub/ui/pages/login_page.dart';
import 'package:passhub/ui/pages/make_own_pass_page.dart';
import 'package:passhub/ui/pages/sign_up_page.dart';
import 'package:passhub/ui/pages/splash_page.dart';
import 'package:passhub/ui/pages/update_password_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
            ),
            BlocProvider(create: (context) => PasswordBloc()),
            BlocProvider(
              create: (context) => CategoryBloc()..add(CategoryGet()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const SplashPage(),
              '/home': (context) => const Home(),
              '/add_pass': (context) => AddPassword(),
              '/login': (context) => LoginPage(),
              '/sign-up': (context) => SignUpPage(),
              '/add_pass_success': (context) => AddPasswordSuccess(),
              '/add_category_success': (context) => AddCategorySuccess(),
              '/add_category': (context) => AddCategoryPage(),
              '/delete_pass_success': (context) => DeletePasswordSuccessPage(),
              '/make-pass': (context) => MakeOwnPassPage(),
              '/update-password': (context) {
                final passwordModel =
                    ModalRoute.of(context)!.settings.arguments as PasswordModel;
                return UpdatePasswordPage(passwordModel: passwordModel);
              },
            },
          ),
        );
      },
    );
  }
}
