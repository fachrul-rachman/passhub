import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/blocs/password/password_bloc.dart';
import 'package:passhub/models/password_model.dart';
import 'package:passhub/shared/themed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCardItem extends StatefulWidget {
  final PasswordModel passwordModel;
  final VoidCallback? onTap;
  final int index;

  const HomeCardItem({
    Key? key,
    required this.passwordModel,
    this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  State<HomeCardItem> createState() => _HomeCardItemState();
}

class _HomeCardItemState extends State<HomeCardItem> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(
        begin: Offset(5.0, 0), // Mulai dari luar layar (kanan)
        end: Offset(0.0, 0), // Berakhir di posisi normal
      ),
      duration: Duration(
          milliseconds:
              1000 + (widget.index * 100)), // Tambahkan delay per item
      curve: Curves.easeOut,
      builder: (context, Offset offset, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: offset.dx == 0 ? 1.0 : 0.0, // Fade-in saat posisi di tengah
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/update-password',
                arguments: widget.passwordModel,
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                bottom: 15.w,
              ),
              width: 331.w,
              height: 150.h,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
                color: greenColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 12.h,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            6.r,
                          ),
                          color: blueDarkColor,
                        ),
                        child: Text(
                          widget.passwordModel.categoryName.toString(),
                          style: greenTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                  "Confirmation",
                                  style: blueTextStyle,
                                ),
                                content: Text(
                                  'Are you sure want delete this data?',
                                  style:
                                      blueTextStyle.copyWith(fontSize: 12.sp),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'No',
                                      style: redTextStyle,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<PasswordBloc>().add(
                                          PasswordDelete(
                                              widget.passwordModel.id!));
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/delete_pass_success',
                                          (route) => false);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: blueTextStyle,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete_rounded,
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.passwordModel.imgPlatform!,
                          width: 71.w,
                          height: 71.h,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 71.h,
                              width: 71.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/logodummy.png',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.passwordModel.platform.toString(),
                            style: blueTextStyle.copyWith(
                              fontSize: 24.sp,
                              fontWeight: bold,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            widget.passwordModel.email!.length > 15
                                ? '${widget.passwordModel.email!.substring(0, 15)}...'
                                : widget.passwordModel.email.toString(),
                            style: blueTextStyle.copyWith(fontSize: 15.sp),
                          ),
                        ],
                      )
                    ],
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
