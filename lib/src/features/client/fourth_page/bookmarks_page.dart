import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/base_app_bar.dart';

@RoutePage()
class BookMarksPage extends StatelessWidget {
  const BookMarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(title: 'Закладки'),
          const SizedBox(height: 50),
          item(),
          item(),
          item(),
        ],
      ),
    );
  }

  Widget item() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kSecondaryGray,
        ),
        padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/png/test_banner.jpg',
                  ),
                ),
              ),
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
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.kMainGreen,
                  ),
                  Text(' 4.8'),
                ],
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
