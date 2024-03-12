import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/custom/common_input.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.grid_view_rounded,
                color: AppColors.kMainGreen,
                size: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.kMainGreen),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset('assets/png/main_profile.png'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Привет, Нурдаулет ',
                style: AppTextStyles.os20w500,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/png/hand.png'),
              ),
            ],
          ),
          const Text(
            'Алматы',
            style: AppTextStyles.os14w500GreyNeutral,
          ),
          const SizedBox(
            height: 20,
          ),
          CommonInput(
            'Поиск',
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.kMainGreen,
              size: 50,
            ),
            style: AppTextStyles.os18w500,
            contentPaddingVertical: 20,
            borderRadius: 25,
            borderColor: AppColors.kMainGreen,
            borderWidth: 1,
            isTexthint: true,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              serviceContainers('assets/svg/restaurant.svg', 'Еда', context),
              serviceContainers('assets/svg/hotel.svg', 'Отель', context),
              serviceContainers('assets/svg/camping.svg', 'Туры', context),
              serviceContainers(
                'assets/svg/airplane.svg',
                'Транспорт',
                context,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 264,
            child: ListView.builder(
              //Нужно заменить на сливер листы
              // padding: const EdgeInsets.only(left: 16, right: 7),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemExtent: 225,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    bannerSliders(
                      'assets/png/test_banner.jpg',
                      'Кокжайлау',
                      'Алматы',
                      '4.9',
                      context,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget serviceContainers(
    String picturePath,
    String data,
    BuildContext context,
  ) =>
      Column(
        children: [
          Container(
            height: context.screenSize.height * 0.06625,
            width: context.screenSize.width * 0.147,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.kSecondaryGray,
            ),
            child: Center(child: SvgPicture.asset(picturePath)),
          ),
          Text(
            data,
            style: AppTextStyles.os12w500.copyWith(color: AppColors.kMainGreen),
          ),
        ],
      );

  Widget bannerSliders(
    String picturePath,
    String placeName,
    String location,
    String rating,
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: () => context.router.push(const ProductRoute()),
        child: Container(
          // height: context.screenSize.height * 0.33,
          // width: context.screenSize.width * 0.575,
          height: 264,
          width: 207,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.kMainGreen),
            image: DecorationImage(image: AssetImage(picturePath)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              saveButton(context),
              const Spacer(),
              Text(
                placeName,
                style: AppTextStyles.os16w500.copyWith(color: AppColors.kWhite),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.kWhite,
                    size: 10,
                  ),
                  Text(
                    location,
                    style: AppTextStyles.os10w400
                        .copyWith(color: AppColors.kMainGreen),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.star_rounded,
                    color: AppColors.kMainGreen,
                    size: 10,
                  ),
                  Text(
                    rating,
                    style: AppTextStyles.os12w500
                        .copyWith(color: AppColors.kWhite),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget saveButton(BuildContext context) => Container(
        height: 28,
        width: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.kMainGreen),
          color: AppColors.kWhite,
        ),
        child: const Icon(
          Icons.bookmark_border_rounded,
          size: 10,
          color: AppColors.kMainGreen,
        ),
      );
}
