import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/app_bar_with_title.dart';

@RoutePage()
class PlannedToursPage extends StatelessWidget {
  const PlannedToursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarWithTitle(title: 'План поездки'),
          item(),
        ],
      ),
    );
  }

  Widget item() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kSecondaryGray,
        ),
        padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6),
        child: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.kMainGreen,
            ),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Кокжайлау\n',
                    style: AppTextStyles.os15w500
                        .copyWith(color: AppColors.kMainGreen),
                  ),
                  const TextSpan(text: 'Алматы', style: AppTextStyles.os13w500),
                ],
              ),
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '10.07.2023',
                style: AppTextStyles.os10w500,
              ),
            ),
            const Icon(
              Icons.more_vert,
              color: AppColors.kMainGreen,
              size: 30,
            ),
          ],
        ),
      );
}
