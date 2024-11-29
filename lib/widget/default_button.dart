import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/app_colors.dart';
import 'package:flutter_dev_test/core/app_sizes.dart';

class DefaultButton extends StatelessWidget {
  String? label;
  void Function()? onTap;
  bool isEnable;
  DefaultButton({
    this.label,
    this.onTap,
    this.isEnable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : () {},
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(AppSizes.marginDefault),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isEnable ? AppColors.brown : AppColors.lightBrown,
              ),
              child: Center(
                child: Text(
                  label ?? 'label',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
