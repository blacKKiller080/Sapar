import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pinput/pinput.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_circle_button.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_loading_widget.dart';
import 'package:sapar/src/features/app/widgets/shimmer_box.dart';
import 'package:sapar/src/features/auth/model/contact_dto.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';
import 'package:sapar/src/features/client/main_page/bloc/favorite_cubit.dart';
import 'package:sapar/src/features/client/main_page/bloc/feedback_cubit.dart';
import 'package:sapar/src/features/client/main_page/bloc/place_cubit.dart';
import 'package:sapar/src/features/client/main_page/contact_bottom_sheet.dart';
import 'package:sapar/src/features/client/main_page/plan_dialog.dart';
import 'package:sapar/src/features/client/main_page/widgets/expandable_widget.dart';

@RoutePage()
class ProductPage extends StatefulWidget {
  final PlaceDTO place;
  const ProductPage({super.key, required this.place});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController commentController = TextEditingController();
  int _currentIndex = 0;
  final List<String> imgList = [
    'assets/png/slider1.png',
    'assets/png/slider2.png',
    'assets/png/slider3.png',
    // Add more images URLs here
  ];

  @override
  Widget build(BuildContext context) {
    return CustomLoadingWidget(
      child: MultiBlocListener(
        listeners: [
          BlocListener<FavoriteCubit, FavoriteState>(
            listener: (context, state) {
              state.whenOrNull(
                loadedState: (favorites) {
                  BlocProvider.of<PlaceCubit>(context)
                      .getPlaceById(id: widget.place.id.toString());
                },
              );
            },
          ),
          BlocListener<FeedbackCubit, FeedbackState>(
            listener: (context, state) {
              state.whenOrNull(
                loadedState: (feedbackDTO) {
                  context.loaderOverlay.hide();
                  BlocProvider.of<PlaceCubit>(context)
                      .getPlaceById(id: widget.place.id.toString());
                },
                loadingState: () {
                  context.loaderOverlay.show();
                },
                errorState: (message) {
                  context.loaderOverlay.hide();
                },
                initialState: () {
                  context.loaderOverlay.hide();
                },
              );
            },
          ),
          BlocListener<PlaceCubit, PlaceState>(
            listener: (context, state) {
              state.whenOrNull(
                loadedAllState: (places) {
                  context.loaderOverlay.hide();
                },
                loadedOneState: (place) {
                  context.loaderOverlay.hide();
                },
                loadingState: () {
                  context.loaderOverlay.show();
                },
                errorState: (message) {
                  context.loaderOverlay.hide();
                },
                initialState: () {
                  context.loaderOverlay.hide();
                },
              );
            },
          ),
        ],
        child: Scaffold(
          body: SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SizedBox(
                height: context.screenSize.height,
                child: CustomScrollView(
                  cacheExtent: 10000,
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  items: widget.place.images!
                                      .map(
                                        (item) => ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              30.0,
                                            ),
                                          ), // Apply rounded corners here
                                          child: Image.network(
                                            item.url,
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
                                    children: widget.place.images!.map((url) {
                                      final int index =
                                          widget.place.images!.indexOf(url);
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                      context.router.popUntil(
                                        (route) =>
                                            route.settings.name ==
                                            LauncherRoute.name,
                                      );
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
                                      BlocBuilder<PlaceCubit, PlaceState>(
                                        builder: (context, state) {
                                          return state.maybeWhen(
                                            loadedAllState: (places) {
                                              var current = 0;
                                              for (final i in places) {
                                                if (i.id == widget.place.id) {
                                                  break;
                                                }
                                                current++;
                                              }
                                              return CustomCircleButton(
                                                onTap: () {
                                                  BlocProvider.of<
                                                      FavoriteCubit>(
                                                    context,
                                                  ).likeProduct(
                                                    id: widget.place.id
                                                        .toString(),
                                                  );
                                                },
                                                border: true,
                                                elevation: 0,
                                                borderColor: AppColors.kGrey6,
                                                child: Icon(
                                                  !places[current].liked
                                                      ? Icons
                                                          .bookmark_border_rounded
                                                      : Icons.bookmark,
                                                  color: AppColors.kMainGreen,
                                                ),
                                              );
                                            },
                                            orElse: () => CustomCircleButton(
                                              onTap: () {
                                                BlocProvider.of<FavoriteCubit>(
                                                  context,
                                                ).likeProduct(
                                                  id: widget.place.id
                                                      .toString(),
                                                );
                                              },
                                              border: true,
                                              elevation: 0,
                                              borderColor: AppColors.kGrey6,
                                              child: Icon(
                                                !widget.place.liked
                                                    ? Icons
                                                        .bookmark_border_rounded
                                                    : Icons.bookmark,
                                                color: AppColors.kMainGreen,
                                              ),
                                            ),
                                          );
                                        },
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.place.name,
                                        style: AppTextStyles.os25w500.copyWith(
                                          color: AppColors.kMainGreen,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star_rounded,
                                      color: AppColors.kMainGreen,
                                      size: 16,
                                    ),
                                    Text(
                                      widget.place.rating.toString(),
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
                                      widget.place.ageRestriction,
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
                                Text(
                                  widget.place.description,
                                  style: AppTextStyles.os12w500,
                                ),
                                const SizedBox(height: 25),
                                BlocBuilder<PlaceCubit, PlaceState>(
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                      loadedAllState: (place) {
                                        var index = 0;
                                        var current = 0;
                                        for (final i in place) {
                                          if (i.id == widget.place.id) {
                                            index = current;
                                            break;
                                          }
                                          current++;
                                        }
                                        log('Current = $index');
                                        if (place[current].feedbacks!.isEmpty) {
                                          return const SizedBox.shrink();
                                        } else {
                                          log('Place id - ${widget.place.id}');
                                          log('Place id from place - ${place[current].id}');
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Отзывы',
                                                    style:
                                                        AppTextStyles.os15w500,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    '(${place[current].feedbacks!.length})',
                                                    style: AppTextStyles
                                                        .os15w400GreyNeutral
                                                        .copyWith(
                                                      color: AppColors.kBlack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                height: 150,
                                                child: ListView.builder(
                                                  itemCount: place[current]
                                                      .feedbacks!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            GestureDetector(
                                                              behavior:
                                                                  HitTestBehavior
                                                                      .opaque,
                                                              onTap: () {
                                                                BlocProvider.of<
                                                                    FeedbackCubit>(
                                                                  context,
                                                                ).likeFeedback(
                                                                  id: place[
                                                                          current]
                                                                      .feedbacks![
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                );
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                size: 15,
                                                                color: place[current]
                                                                            .feedbacks![
                                                                                index]
                                                                            .likes >
                                                                        0
                                                                    ? AppColors
                                                                        .kRed
                                                                    : AppColors
                                                                        .kBlack,
                                                              ),
                                                            ),
                                                            Text(
                                                              place[current]
                                                                  .feedbacks![
                                                                      index]
                                                                  .likes
                                                                  .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              ExpandableWidget(
                                                            content:
                                                                place[current]
                                                                    .feedbacks![
                                                                        index]
                                                                    .comment,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                      orElse: () {
                                        return Column(
                                          children: [
                                            const Row(
                                              children: [
                                                Text(
                                                  'Отзывы',
                                                  style: AppTextStyles.os15w500,
                                                ),
                                                SizedBox(width: 20),
                                                ShimmerBox(
                                                  height: 15,
                                                  width: 25,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                              height: 80,
                                              child: ListView.builder(
                                                itemCount: widget
                                                    .place.feedbacks?.length,
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .favorite_border,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            widget
                                                                .place
                                                                .feedbacks![
                                                                    index]
                                                                .likes
                                                                .toString(),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: ExpandableWidget(
                                                          content: widget
                                                              .place
                                                              .feedbacks![index]
                                                              .comment,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                // if (widget.place.feedbacks!.isEmpty) ...[
                                //   const SizedBox.shrink(),
                                // ] else ...[
                                //   Row(
                                //     children: [
                                //       const Text(
                                //         'Отзывы',
                                //         style: AppTextStyles.os15w500,
                                //       ),
                                //       const SizedBox(width: 20),
                                //       Text(
                                //         '(${widget.place.feedbacks!.length})',
                                //         style: AppTextStyles.os15w400GreyNeutral
                                //             .copyWith(color: AppColors.kBlack),
                                //       ),
                                //     ],
                                //   ),
                                //   const SizedBox(height: 5),
                                //   SizedBox(
                                //     height: 70,
                                //     child: ListView.builder(
                                //       itemCount: widget.place.feedbacks?.length,
                                //       itemBuilder: (context, index) {
                                //         return Row(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Column(
                                //               children: [
                                //                 const Icon(
                                //                   Icons.favorite_border,
                                //                   size: 15,
                                //                 ),
                                //                 Text(
                                //                   widget.place.feedbacks![index]
                                //                       .likes
                                //                       .toString(),
                                //                 ),
                                //               ],
                                //             ),
                                //             const SizedBox(width: 4),
                                //             Expanded(
                                //               child: ExpandableWidget(
                                //                 content: widget.place
                                //                     .feedbacks![index].comment,
                                //               ),
                                //             ),
                                //           ],
                                //         );
                                //       },
                                //     ),
                                //   ),
                                // ],
                                TextFormField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    labelText: 'Comment here...',
                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(Icons.send),
                                      onPressed: () {
                                        if (commentController.text.isNotEmpty) {
                                          BlocProvider.of<FeedbackCubit>(
                                            context,
                                          ).createFeedback(
                                            comment: commentController.text,
                                            placeId: widget.place.id,
                                          );
                                          commentController.setText('');
                                        }
                                      },
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    focusColor: AppColors.kBlack,
                                    focusedBorder: const UnderlineInputBorder(),
                                    labelStyle: AppTextStyles.os16w400,
                                  ),
                                  maxLines: null,
                                ),
                                // const CommonInput(
                                //   'Comment here...',
                                //   borderColor: AppColors.kBlack,
                                //   suffixIcon: const Icon(Icons.send),
                                // ),
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
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            height: 97,
                                            width: 80,
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                    style:
                                                        AppTextStyles.os10w400,
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
                                          ContactBottomSheet.show(
                                            context,
                                            widget.place.contacts ??
                                                const Contacts(
                                                  id: 1,
                                                  site: 'site.kz',
                                                  phone: '87777777777',
                                                  insta: 'insta',
                                                ),
                                          );
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
                                          // planDialog(context);
                                          PlanDialog.show(
                                            context,
                                            widget.place,
                                          );
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
                                              style: AppTextStyles.os13w500
                                                  .copyWith(
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
          ),
        ),
      ),
    );
  }
}
