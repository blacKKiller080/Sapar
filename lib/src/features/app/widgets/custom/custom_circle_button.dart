import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    required this.onTap,
    required this.child,
    this.size = 44,
    this.iconColor = Colors.black,
    this.buttonColor = AppColors.kWhite,
    this.borderColor = AppColors.kMainGreen,
    this.elevation = 3,
    this.border = false,
    super.key,
  });
  final Function()? onTap;
  final double size;
  final Color iconColor;
  final Color buttonColor;
  final double elevation;
  final Widget child;
  final bool border;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: buttonColor,
      shape: border
          ? RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            )
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: SizedBox(
          height: size,
          width: size,
          child: child,
        ),
      ),
    );
  }
}
