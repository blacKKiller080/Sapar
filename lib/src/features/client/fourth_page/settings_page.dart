import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/bloc/app_bloc.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/base_app_bar.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_switch.dart';
import 'package:sapar/src/features/client/fourth_page/locale_bottom_sheet.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(title: 'Настройки'),
          const SizedBox(height: 50),
          profileContainer(context),
          const SizedBox(height: 50),
          settingsContainer(context),
          CommonButton(
            onPressed: () {
              context.appBloc.add(const AppEvent.exiting());
            },
            margin: const EdgeInsets.symmetric(horizontal: 43, vertical: 35),
            child: const Text('Выход'),
          )
        ],
      ),
    );
  }

  Widget profileContainer(BuildContext context) => GestureDetector(
        onTap: () => context.router.push(const EditProfileRoute()),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 43),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.kSecondaryGray,
          ),
          padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8, right: 8),
          child: Row(
            children: [
              Container(
                width: 51,
                height: 51,
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
              const SizedBox(width: 14),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Нурдаулет\n',
                      style: AppTextStyles.os20w500,
                    ),
                    TextSpan(
                      text: 'nurdaulet@mail.ru',
                      style: AppTextStyles.os14w400
                          .copyWith(color: AppColors.kTextSecondary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 40,
              ),
            ],
          ),
        ),
      );

  Widget settingsContainer(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 43),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kSecondaryGray,
        ),
        padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8, right: 8),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.kElementsSecondary,
                  size: 40,
                ),
                const SizedBox(width: 14),
                const Text(
                  'Уведомления',
                  style: AppTextStyles.os14w400,
                ),
                const Spacer(),
                CupertinoSwitchButton(
                  forIos: false,
                )
              ],
            ),
            const SizedBox(height: 15),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => LocaleBottomSheet.show(context),
              child: const Row(
                children: [
                  Icon(
                    Icons.language,
                    color: AppColors.kElementsSecondary,
                    size: 40,
                  ),
                  SizedBox(width: 14),
                  Text(
                    'Язык',
                    style: AppTextStyles.os14w400,
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.privacy_tip_outlined,
                  color: AppColors.kElementsSecondary,
                  size: 40,
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Политика конфиденциальности',
                    style: AppTextStyles.os14w400,
                    maxLines: 2,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      );
}
