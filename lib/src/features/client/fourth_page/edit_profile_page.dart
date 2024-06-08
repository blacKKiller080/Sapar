import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/base_app_bar.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/auth/model/user_dto.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  final UserDTO user;
  const EditProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(title: 'Личные данные'),
          const SizedBox(height: 50),
          profileContainer(user),
        ],
      ),
    );
  }

  Widget profileContainer(UserDTO user) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 43),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kSecondaryGray,
        ),
        padding: const EdgeInsets.only(left: 16, top: 15, bottom: 8, right: 16),
        child: Column(
          children: [
            Container(
              width: 63,
              height: 63,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.kMainGreen),
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/png/test_banner.jpg',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              user.name,
              style: AppTextStyles.os20w500,
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const Text(
                  'Ваш логин',
                  style: AppTextStyles.os12w500,
                ),
                const Spacer(),
                Text(
                  'nurdaulet@mail.ru',
                  style: AppTextStyles.os12w500
                      .copyWith(color: AppColors.kTextSecondary),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                const Text(
                  'Изменить пароль',
                  style: AppTextStyles.os12w500,
                ),
                const Spacer(),
                Text(
                  '*******',
                  style: AppTextStyles.os12w500
                      .copyWith(color: AppColors.kTextSecondary),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                const Text(
                  'Номер телефона',
                  style: AppTextStyles.os12w500,
                ),
                const Spacer(),
                Text(
                  user.phone,
                  style: AppTextStyles.os12w500
                      .copyWith(color: AppColors.kTextSecondary),
                ),
              ],
            ),
            const SizedBox(height: 11),
            CommonButton(
              margin: const EdgeInsets.symmetric(horizontal: 43, vertical: 35),
              child: const Text('Сохранить'),
            ),
          ],
        ),
      );
}
