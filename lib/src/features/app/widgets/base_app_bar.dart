import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_back_button.dart';

class BaseAppBar extends StatelessWidget {
  final TextStyle? titleStyle;
  final String title;
  final bool showBottomBorder;
  final Widget? trailing;
  final IconData? icon;
  const BaseAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.showBottomBorder = true,
    this.trailing,
    this.icon = Icons.arrow_back,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomBackButton(
            padding: EdgeInsets.only(left: 10, bottom: 12, top: 12),
          ),
          // if (trailing != null) const SizedBox(width: 0),
          Text(
            title,
            style: titleStyle ?? AppTextStyles.os20w500,
          ),
          if (trailing != null)
            trailing!
          else
            const SizedBox(
              width: 30,
            ),
        ],
      ),
    );
  }
}
