import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sapar/src/core/resources/resources.dart';

class CustomTabWidget extends StatelessWidget {
  final String icon;
  final String activeIcon;
  final String title;
  final int currentIndex;
  final int tabIndex;
  const CustomTabWidget({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.title,
    required this.currentIndex,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Tab(
        iconMargin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              tabIndex == currentIndex ? activeIcon : icon,
              colorFilter: tabIndex == currentIndex
                  ? const ColorFilter.mode(
                      AppColors.kMainGreen,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.os10w500.copyWith(
                color: tabIndex == currentIndex
                    ? AppColors.kMainGreen
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
