import 'package:flutter/material.dart';

import '../../../../core/resources/resources.dart';

class CustomButton extends StatelessWidget {
  final Widget? body;
  final void Function()? onClick;
  final ButtonStyle style;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.body,
    required this.onClick,
    required this.style,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height == 0 ? null : height,
      child: ElevatedButton(
        onPressed: onClick,
        style: style,
        child: body,
      ),
    );
  }
}

ButtonStyle whiteButtonStyle({
  double elevation = 0,
  double radius = 4,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kFoundationGrey,
    backgroundColor: Colors.white,
    elevation: elevation,
    shadowColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: const BorderSide(
        color: Color(0xffD9D9D9),
        width: 0.8,
      ),
    ),
  );
}

ButtonStyle whiteButtonStyleWithShadow({
  double elevation = 7,
  double radius = 8,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kFoundationGrey,
    backgroundColor: Colors.white,
    elevation: elevation,
    shadowColor: AppColors.kNeutralGray50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: const BorderSide(
        color: AppColors.kNeutralGray50,
        width: 0.33,
      ),
    ),
  );
}

ButtonStyle greyButtonWithBlackOverlayStyle({
  double elevation = 0,
  double radius = 12,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kBlack,
    backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
    elevation: elevation,
    shadowColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

ButtonStyle orangeButtonWithOrangeOverlayStyle({
  double elevation = 0,
  double radius = 12,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kOrange,
    backgroundColor: const Color.fromRGBO(255, 122, 41, 0.12),
    elevation: elevation,
    shadowColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

ButtonStyle foundationGreyButtonStyle({
  double elevation = 0,
  double radius = 4,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kFoundationGrey,
    backgroundColor: AppColors.kFoundationGreyLight,
    elevation: elevation,
    shadowColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

ButtonStyle authButtonStyle({
  double elevation = 0,
  double radius = 4,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kWhite,
    backgroundColor: AppColors.kBlue,
    // shadowColor: const Color.fromRGBO(255, 255, 255, 1),
    elevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: const BorderSide(color: Colors.white),
    ),
  );
}

ButtonStyle blueButtonStyle({
  double elevation = 0,
  double radius = 10,
  Color? backgroundColor = AppColors.kBlue,
  Color? foregroundColor = AppColors.kWhite,
  Color? disabledBackgroundColor = AppColors.kFoundationGreyLightHover,
  Color? shadowColor = const Color.fromRGBO(255, 255, 255, 1),
  BorderRadiusGeometry? borderRadius,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: foregroundColor,
    backgroundColor: backgroundColor,
    shadowColor: shadowColor,
    disabledBackgroundColor: disabledBackgroundColor,
    elevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      // side: const BorderSide(color: Colors.white),
    ),
  );
}

ButtonStyle greyButtonStyle({
  double elevation = 0,
  double radius = 10,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kWhite,
    backgroundColor: AppColors.kGrey,
    shadowColor: const Color.fromRGBO(255, 255, 255, 1),
    elevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      // side: const BorderSide(color: Colors.white),
    ),
  );
}

ButtonStyle greenButtonStyle({
  double elevation = 0,
  double radius = 4,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kWhite,
    backgroundColor: AppColors.kGreen,
    shadowColor: const Color.fromRGBO(255, 255, 255, 1),
    elevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      // side: const BorderSide(color: Colors.white),
    ),
  );
}

ButtonStyle greenDarkButtonStyle({
  double elevation = 0,
  double radius = 4,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: AppColors.kWhite,
    backgroundColor: AppColors.kDarkGreen,
    shadowColor: const Color.fromRGBO(255, 255, 255, 1),
    elevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      // side: const BorderSide(color: Colors.white),
    ),
  );
}

ButtonStyle blueAlpha32ButtonStyle({
  double elevation = 0,
}) {
  return ElevatedButton.styleFrom(
    // foregroundColor: AppColors.kGray400,
    backgroundColor: const Color(0xffe5f1ff),
    shadowColor: Colors.white,
    elevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      // side: const BorderSide(color: Colors.white),
    ),
  );
}
