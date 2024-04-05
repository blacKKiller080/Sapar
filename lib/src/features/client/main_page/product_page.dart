import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_circle_button.dart';
import 'package:sapar/src/features/client/main_page/contact_bottom_sheet.dart';
import 'package:sapar/src/features/client/main_page/plan_dialog.dart';

@RoutePage()
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController scrollController = ScrollController();
  int _currentIndex = 0;
  final List<String> imgList = [
    'assets/png/slider1.png',
    'assets/png/slider2.png',
    'assets/png/slider3.png',
    // Add more images URLs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: context.screenSize.height,
          child: CustomScrollView(
            cacheExtent: 10000,
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 400.0,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: imgList
                                .map(
                                  (item) => ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        30.0,
                                      ),
                                    ), // Apply rounded corners here
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.cover,
                                      width: 1000,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.map((url) {
                                final int index = imgList.indexOf(url);
                                return Container(
                                  width: _currentIndex == index
                                      ? 30.0
                                      : 10.0, // Expand the width if current index
                                  height: 10.0,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 2.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: _currentIndex == index
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Positioned(
                            top: 25,
                            left: 25,
                            child: CustomCircleButton(
                              onTap: () {
                                context.router.pop();
                              },
                              border: true,
                              elevation: 0,
                              borderColor: AppColors.kGrey6,
                              child: const Icon(
                                Icons.arrow_back,
                                color: AppColors.kMainGreen,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 25,
                            right: 20,
                            child: Row(
                              children: [
                                CustomCircleButton(
                                  onTap: () {},
                                  border: true,
                                  elevation: 0,
                                  borderColor: AppColors.kGrey6,
                                  child: const Icon(
                                    Icons.bookmark_border_outlined,
                                    color: AppColors.kMainGreen,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                CustomCircleButton(
                                  onTap: () {},
                                  border: true,
                                  elevation: 0,
                                  borderColor: AppColors.kGrey6,
                                  child: const Icon(
                                    Icons.ios_share_outlined,
                                    color: AppColors.kMainGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                'Кокжайлау',
                                style: AppTextStyles.os25w500
                                    .copyWith(color: AppColors.kMainGreen),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.kMainGreen,
                                size: 10,
                              ),
                              const Text(
                                '4.9',
                                style: AppTextStyles.os12w500,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Маршрут',
                                style: AppTextStyles.os12w500,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                'Алматинская область',
                                style: AppTextStyles.os12w500
                                    .copyWith(color: AppColors.kGrey6),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Категория',
                                style: AppTextStyles.os12w500,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                'Туры',
                                style: AppTextStyles.os12w500
                                    .copyWith(color: AppColors.kGrey6),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Расстояние',
                                style: AppTextStyles.os12w500,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                '10км',
                                style: AppTextStyles.os12w500
                                    .copyWith(color: AppColors.kGrey6),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Возраст',
                                style: AppTextStyles.os12w500,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                '18 - 45км',
                                style: AppTextStyles.os12w500
                                    .copyWith(color: AppColors.kGrey6),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Описание',
                            style: AppTextStyles.os15w500,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Кок-Жайляу — урочище на территории Иле-Алатауского государственного национального природного парка, расположенное с востока на запад между Малым и Большим Алматинскими ущельями в 10 км от города Алматы в Казахстане. Абсолютная высота урочища - 1450-1740 м над уровнем моря.',
                            style: AppTextStyles.os12w500,
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              const Text(
                                'Отзывы',
                                style: AppTextStyles.os15w500,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                '(155)',
                                style: AppTextStyles.os15w400GreyNeutral
                                    .copyWith(color: AppColors.kBlack),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Ближайшие',
                            style: AppTextStyles.os15w500,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              //Нужно заменить на сливер листы
                              // padding: const EdgeInsets.only(left: 16, right: 7),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemExtent: 90,

                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      // height: context.screenSize.height * 0.33,
                                      // width: context.screenSize.width * 0.575,
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 97,
                                      width: 80,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: AppColors.kMainGreen,
                                          width: 2,
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                            'assets/png/test_banner.jpg',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 80,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Кокжайлау',
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: AppTextStyles.os10w400,
                                            ),
                                          ),
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.kMainGreen,
                                            size: 10,
                                          ),
                                          Text(
                                            '4.9',
                                            style: AppTextStyles.os10w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CommonButton(
                                  onPressed: () {
                                    ContactBottomSheet.show(context);
                                  },
                                  miniButton: true,
                                  borderColor: AppColors.kMainGreen,
                                  backgroundColor: Colors.transparent,
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColors.kBlack,
                                        size: 18,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Связываться',
                                        style: AppTextStyles.os13w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: CommonButton(
                                  onPressed: () {
                                    planDialog(context);
                                  },
                                  miniButton: true,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_rounded,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Планировать',
                                        style: AppTextStyles.os13w500.copyWith(
                                          color: AppColors.kWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
