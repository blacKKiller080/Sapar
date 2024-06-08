import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sapar/src/core/resources/resources.dart';

class CustomTabWidget extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final int currentIndex;
  final int tabIndex;
  const CustomTabWidget({
    super.key,
    required this.icon,
    required this.activeIcon,
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
            Icon(
              tabIndex == currentIndex ? activeIcon : icon,
              color: tabIndex == currentIndex
                  ? AppColors.kMainGreen
                  : AppColors.kGrey6,
              size: 35,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
