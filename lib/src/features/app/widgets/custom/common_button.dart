// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';

class CommonButton extends StatelessWidget {
  Widget child;
  Function? onPressed;
  Widget? icon;

  EdgeInsets? margin;
  final Color backgroundColor;
  final Color foregroundColor;
  Color? borderColor;
  final double borderWidth;

  bool success;
  bool disabled;

  double contentPaddingVertical;
  double fontSize;
  bool miniButton;
  bool hasDownIcon;
  double? radius;
  double? containerWidth;
  double? containerHeight;

  bool bigText;
  double contentPaddingHorizontal;
  bool shadow;
  FontWeight fontWeight;

  CommonButton({
    required this.child,
    this.onPressed,
    this.radius = 16,
    this.success = true,
    this.disabled = false,
    this.borderColor,
    this.backgroundColor = AppColors.kMainGreen,
    this.foregroundColor = AppColors.kWhite,
    this.margin,
    this.contentPaddingVertical = 17.5,
    this.fontSize = 16,
    this.miniButton = false,
    this.hasDownIcon = false,
    this.icon,
    this.contentPaddingHorizontal = 0,
    this.bigText = true,
    this.shadow = false,
    this.fontWeight = FontWeight.w500,
    this.containerWidth,
    this.containerHeight,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height / 100;
    // var width = MediaQuery.of(context).size.width / 100;
    return Container(
      margin: margin,
      decoration: shadow
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2.5,
                  blurRadius: 7,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            )
          : BoxDecoration(),
      child: TextButton(
        onPressed: () {
          if (!disabled && success) {
            onPressed?.call();
          }
        },
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: MaterialStateProperty.all(Size(0, 0)),
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateProperty.all(getBackgroundColor()),
          foregroundColor: MaterialStateProperty.all(getForegroundColor()),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? backgroundColor,
                width: borderWidth,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(radius!),
              ),
            ),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontFamily: 'NotoSans',
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              vertical: contentPaddingVertical,
              horizontal: contentPaddingHorizontal,
            ),
          ),
        ),
        child: !miniButton
            ? hasDownIcon
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      child,
                      SizedBox(child: icon),
                    ],
                  )
                : SizedBox(
                    width: containerWidth ?? double.infinity,
                    height: containerHeight,
                    child: Center(child: child),
                  )
            : Container(
                padding:
                    EdgeInsets.symmetric(horizontal: contentPaddingHorizontal),
                // constraints: const BoxConstraints(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    child,
                  ],
                ),
              ),
      ),
    );
  }

  Color getBackgroundColor() {
    Color color;
    if (disabled) {
      color = Color(0x29009C73);
      borderColor = Color(0x29009C73);
    } else {
      color = backgroundColor;
    }
    return color;
  }

  Color getForegroundColor() {
    Color color;
    if (disabled) {
      color = AppColors.kWhite;
    } else {
      color = foregroundColor;
    }
    return color;
  }
}
