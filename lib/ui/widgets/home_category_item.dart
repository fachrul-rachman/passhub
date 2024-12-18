import 'package:flutter/material.dart';
import 'package:passhub/models/category_model.dart';
import 'package:passhub/shared/themed.dart';

class HomeCategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final bool isSelected;
  final VoidCallback? onTap;

  const HomeCategoryItem({
    Key? key,
    required this.categoryModel,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? redColor : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(categoryModel.categoryName.toString(),
            style: greenTextStyle.copyWith(
              fontSize: 16,
              fontWeight: isSelected ? bold : regular,
            )),
      ),
    );
  }
}
