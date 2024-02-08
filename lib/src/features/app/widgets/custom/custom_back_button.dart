import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? onTap;
  final EdgeInsets? padding;
  const CustomBackButton({
    super.key,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onTap?.call() ?? context.router.pop();
      },
      icon: const Icon(Icons.keyboard_arrow_left),
      padding: padding ?? const EdgeInsets.only(top: 10, bottom: 30),
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      iconSize: 30,
      constraints: const BoxConstraints(),
    );
  }
}
