import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/bloc/app_bloc.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            height: context.screenSize.height,
            width: context.screenSize.width,
            'assets/png/onboarding.png',
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: context.mediaQuery.viewPadding.bottom > 20
                ? context.mediaQuery.viewPadding.bottom + 15
                : 35,
            left: 16,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => context.appBloc.add(const AppEvent.onboardingSave()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Добро пожаловать!',
                        style: AppTextStyles.os25w500
                            .copyWith(color: AppColors.kWhite),
                      ),
                      const SizedBox(width: 16),
                      SvgPicture.asset('assets/icons/hand.svg'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Казахстан',
                        style: AppTextStyles.os32w700
                            .copyWith(color: AppColors.kMainGreen),
                      ),
                      SizedBox(width: context.screenSize.width * 0.2),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.kMainGreen,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
