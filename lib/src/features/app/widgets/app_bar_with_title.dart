import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';

class AppBarWithTitle extends StatelessWidget {
  final TextStyle? titleStyle;
  final String title;
  const AppBarWithTitle({super.key, this.titleStyle, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: titleStyle ?? AppTextStyles.os16w600,
          ),
        ],
      ),
    );
  }
}
