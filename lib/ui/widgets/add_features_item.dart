import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passhub/shared/themed.dart';

class AddFeaturesItem extends StatefulWidget {
  final String category;
  final String subtitle;
  final int initialValue;
  final ValueChanged<int> onNumberChange; // Callback untuk mengirim nilai angka

  const AddFeaturesItem({
    Key? key,
    required this.category,
    required this.subtitle,
    required this.initialValue,
    required this.onNumberChange,
  }) : super(key: key);

  @override
  State<AddFeaturesItem> createState() => _AddFeaturesItemState();
}

class _AddFeaturesItemState extends State<AddFeaturesItem> {
  late int number;

  @override
  void initState() {
    super.initState();
    number = widget.initialValue; // Set angka awal
  }

  void _increment() {
    setState(() {
      number++;
    });
    widget.onNumberChange(number); // Kirim nilai ke parent
  }

  void _decrement() {
    if (number > 0) {
      setState(() {
        number--;
      });
      widget.onNumberChange(number); // Kirim nilai ke parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.category,
                    style: blueTextStyle.copyWith(
                        fontSize: 18.sp, fontWeight: medium)),
                TextSpan(
                  text: widget.subtitle,
                  style: blueTextStyle.copyWith(
                    fontSize: 13.sp,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: _decrement,
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: blueDarkColor,
                  ),
                  child: Icon(
                    Icons.remove_rounded,
                    color: greenColor,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                '$number',
                style:
                    blueTextStyle.copyWith(fontSize: 16.sp, fontWeight: medium),
              ),
              SizedBox(width: 5.w),
              GestureDetector(
                onTap: _increment,
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: blueDarkColor,
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: greenColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
