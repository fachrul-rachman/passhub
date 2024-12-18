import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/models/password_model.dart';
import 'package:passhub/shared/themed.dart';
import 'package:passhub/ui/widgets/buttons.dart';
import 'package:passhub/ui/widgets/updateForm.dart';

class UpdatePasswordPage extends StatefulWidget {
  final PasswordModel passwordModel;

  const UpdatePasswordPage({
    Key? key,
    required this.passwordModel,
  }) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late TextEditingController platformController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController categoryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    platformController =
        TextEditingController(text: widget.passwordModel.platform);
    emailController = TextEditingController(text: widget.passwordModel.email);
    passwordController =
        TextEditingController(text: widget.passwordModel.password);
    categoryController =
        TextEditingController(text: widget.passwordModel.categoryName);
  }

  @override
  void dispose() {
    platformController.dispose();
    emailController.dispose();
    passwordController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              // image: DecorationImage(
              //   image: NetworkImage(widget.passwordModel.imgPlatform ?? ''),
              // ),
              color: greenColor,
            ),
            child: Column(
              children: [
                Container(
                  width: 97.w,
                  height: 97.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image:
                          NetworkImage(widget.passwordModel.imgPlatform ?? ''),
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
                CustomFormFieldUpdate(
                  title: 'Platform',
                  controller: platformController,
                  isShowTitle: false,
                  onlyRead: true,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormFieldUpdate(
                  title: 'Account Id',
                  controller: emailController,
                  isShowTitle: false,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormFieldUpdate(
                  title: 'Password',
                  controller: passwordController,
                  isShowTitle: false,
                  obscureText: true,
                  isPin: true,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormFieldUpdate(
                  title: 'Category',
                  controller: categoryController,
                  isShowTitle: false,
                  obscureText: false,
                  onlyRead: true,
                ),
                SizedBox(
                  height: 22.h,
                ),
                CustomFilledButton(
                  title: 'Update',
                  onPressed: () {
                    // final updatePassword = PasswordModel(
                    //   id: widget.passwordModel.id,
                    //   platform: platformController.text,
                    //   imgPlatform: widget.passwordModel.imgPlatform,
                    //   email: emailController.text,
                    //   password: passwordController.text,
                    //   categoryId: widget.passwordModel.categoryId,
                    //   categoryName: categoryController.text,
                    // );
                    //
                    // context.read<PasswordBloc>().add(
                    //       PasswordUpdate(updatedPassword),
                    //     );
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
