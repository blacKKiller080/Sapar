import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTwoWidgetsRow extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;
  double? paddingHorizontal;

  CustomTwoWidgetsRow({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
    this.paddingHorizontal = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal!),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftWidget,
          rightWidget,
        ],
      ),
    );
  }
}
