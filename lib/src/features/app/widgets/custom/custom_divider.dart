import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double? leftPadding;
  final double? rightPadding;

  const CustomDivider({
    super.key,
    this.height = 36,
    this.thickness = 0.3,
    this.leftPadding,
    this.rightPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: leftPadding ?? 0, right: rightPadding ?? 0),
      child: Divider(
        color: const Color(0xFFC8C7CC),
        thickness: thickness,
        height: height,
      ),
    );
  }
}
