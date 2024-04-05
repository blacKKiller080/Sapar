import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/enum/app_language.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_circle_button.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_divider.dart';
import 'package:sapar/src/features/settings/widget/scope/settings_scope.dart';

class LocaleBottomSheet extends StatefulWidget {
  const LocaleBottomSheet({super.key});

  static Future<void> show(
    BuildContext context,
  ) async =>
      showModalBottomSheet(
        context: context,
        enableDrag: true,
        useRootNavigator: true,
        barrierColor: Colors.black.withOpacity(0.25),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        builder: (_) => const LocaleBottomSheet(),
      );

  @override
  State<LocaleBottomSheet> createState() => _LocaleBottomSheetState();
}

class _LocaleBottomSheetState extends State<LocaleBottomSheet> {
  AppLanguage? appLang;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(top: 12),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 34,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 40,
              ),
              const Text(
                'Язык приложения',
                style: AppTextStyles.os20w700,
              ),
              CustomCircleButton(
                size: 24,
                elevation: 0,
                buttonColor: AppColors.kSurfaceSecondary,
                child: const Icon(
                  Icons.close,
                  size: 12,
                  color: AppColors.kElementsTertiary,
                ),
                onTap: () {
                  context.router.pop();
                },
              ),
            ],
          ),
          const CustomDivider(height: 16),
          // const SizedBox(height: 10),
          Column(
            children: List.generate(
              AppLanguage.values.length,
              (index) => Column(
                children: [
                  SizedBox(
                    // color: AppColors.kBlue,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          // appLang = AppLanguage.values[index];
                          // locale = AppLanguage.values[index].title;
                          // localeCode = AppLanguage.values[index].localeCode;
                          context.dio.options.headers['Content-Language'] =
                              AppLanguage.values[index].localeCode;
                          SettingsScope.setLocale(
                            context,
                            AppLanguage.values[index],
                          );
                          context.router.pop();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLanguage.values[index].title,
                              style: AppTextStyles.os16w600,
                              textAlign: TextAlign.center,
                            ),
                            Radio(
                              value: AppLanguage.values[index].localeCode ==
                                      context.localized.localeName
                                  ? 0
                                  : 1,
                              visualDensity: VisualDensity.compact,
                              groupValue: 0,
                              activeColor: AppColors.kMainGreen,
                              onChanged: (p0) {
                                context.dio.options
                                        .headers['Content-Language'] =
                                    AppLanguage.values[index].localeCode;
                                SettingsScope.setLocale(
                                  context,
                                  AppLanguage.values[index],
                                );
                                context.router.pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const CustomDivider(height: 28),
                ],
              ),
            ),
          ),
          CommonButton(
            onPressed: () {
              // if (appLang != null) {
              //   context.dio.options.headers['Content-Language'] =
              //       appLang!.localeCode;
              //   SettingsScope.setLocale(context, appLang!);
              context.router.pop();
              // }
            },
            margin: const EdgeInsets.only(bottom: 10),
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.kTextBrandPrimary,
            contentPaddingVertical: 14,
            fontWeight: FontWeight.w600,
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}
