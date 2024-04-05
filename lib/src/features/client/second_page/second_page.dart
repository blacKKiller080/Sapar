import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/app_bar_with_title.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarWithTitle(title: 'Уведомления'),
          item(),
          item(),
          item(),
          item(),
        ],
      ),
    );
  }

  Widget item() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kSecondaryGray,
          border: Border.all(color: AppColors.kMainGreen),
        ),
        padding: const EdgeInsets.only(left: 13, top: 10, bottom: 10),
        child: Row(
          children: [
            const Icon(
              Icons.notifications_none_sharp,
              color: AppColors.kMainGreen,
              size: 26,
            ),
            const SizedBox(width: 8),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Новые уведомления\n',
                    style: AppTextStyles.os13w500,
                  ),
                  TextSpan(
                    text: 'Открылось новое место в городе',
                    style: AppTextStyles.os10w400,
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: AppColors.kMainGreen,
              size: 30,
            ),
          ],
        ),
      );
}
