import 'package:flutter/material.dart';

import 'package:flutter_wrap_architecture/src/core/resources/resources.dart';

// ignore: must_be_immutable
class CustomCheckbox extends StatelessWidget {
  final bool isSelect;
  final Function() onTap;
  double? size;
  CustomCheckbox({
    super.key,
    required this.isSelect,
    required this.onTap,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: !isSelect
          ? Container(
              width: size,
              height: size,
              // padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.kElementsTertiary,
                ),
              ),
              child: const SizedBox(),
            )
          : SizedBox(
              width: size,
              height: size,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.kTextBrandPrimary,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.kWhite,
                  size: 9,
                ),
              ),
            ),
    );
  }
}
