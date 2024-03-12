import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/base_app_bar.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_circle_button.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseAppBar(
          title: 'Профиль',
          trailing: GestureDetector(
            onTap: () {
              context.router.push(const SettingsRoute());
            },
            child: const Icon(
              Icons.settings,
              size: 30,
              color: AppColors.kMainGreen,
            ),
          ),
        ),
        const SizedBox(height: 50),
        const CircleAvatar(
          backgroundColor: AppColors.kMainGreen,
          radius: 60,
          // backgroundImage: AssetImage('assets/png/test_banner.jpg'),
          foregroundImage: AssetImage('assets/png/test_banner.jpg'),
          // child: Image.asset('assets/png/test_banner.jpg'),
          // Icon(
          //   Icons.account_circle,
          //   size: 120,
          //   color: AppColors.kBlue,
          // ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Нурдаулет',
          style: AppTextStyles.os20w500,
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircleButton(
              onTap: () {},
              border: true,
              elevation: 0,
              child: const Icon(
                Icons.location_on_outlined,
                color: AppColors.kMainGreen,
              ),
            ),
            const SizedBox(width: 20),
            CustomCircleButton(
              onTap: () {
                context.router.push(const BookMarksRoute());
              },
              border: true,
              elevation: 0,
              child: const Icon(
                Icons.bookmark,
                color: AppColors.kMainGreen,
              ),
            ),
            const SizedBox(width: 20),
            CustomCircleButton(
              onTap: () {},
              border: true,
              elevation: 0,
              child: const Icon(
                Icons.calendar_today,
                color: AppColors.kMainGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        const Text(
          'Фотографии',
          style: AppTextStyles.os20w600,
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageContainer(),
                const SizedBox(width: 9),
                imageContainer(),
                const SizedBox(width: 9),
                imageContainer(),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageContainer(),
                const SizedBox(width: 9),
                imageContainer(),
                const SizedBox(width: 9),
                imageContainer(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget imageContainer() => SizedBox(
        height: 80,
        width: 80,
        child: Image.asset('assets/png/image_container.png'),
      );
}
