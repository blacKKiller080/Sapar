import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sapar/src/core/common/constants.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/custom/common_input.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_loading_widget.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_snackbars.dart';
import 'package:sapar/src/features/app/widgets/shimmer_box.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';
import 'package:sapar/src/features/client/main_page/bloc/favorite_cubit.dart';
import 'package:sapar/src/features/client/main_page/bloc/place_cubit.dart';
import 'package:sapar/src/features/client/main_page/widgets/custom_search_delegate.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, dynamic> data = {
    "image": 'assets/png/test_banner.jpg',
    "place": 'Кокжайлау',
    "city": 'Алматы',
    "rating": '4.9',
  };
  void _updateList(int buttonIndex) {
    setState(() {
      switch (buttonIndex) {
        case 1:
          data = {
            "image": 'assets/png/test_banner.jpg',
            "place": 'Кокжайлау',
            "city": 'Алматы',
            "rating": '4.9',
          };
        case 2:
          data = {
            "image": 'assets/png/shafran.png',
            "place": 'Shafran',
            "city": 'Алматы',
            "rating": '4.5',
          };
        case 3:
          data = {
            "image": 'assets/png/test_banner.jpg',
            "place": 'Кокжайлау',
            "city": 'Алматы',
            "rating": '4.9',
          };
        case 4:
          data = {
            "image": 'assets/png/test_banner.jpg',
            "place": 'Кокжайлау',
            "city": 'Алматы',
            "rating": '4.9',
          };
        default:
          data = {
            "image": 'assets/png/test_banner.jpg',
            "place": 'Кокжайлау',
            "city": 'Алматы',
            "rating": '4.9',
          };
      }
    });
  }

  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController = RefreshController();
  List<PlaceDTO> placeList = [];

  List<String> searchHistory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PlaceCubit>(context).getAllPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoadingWidget(
      child: BlocListener<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          state.whenOrNull(
            loadedState: (favorites) {
              BlocProvider.of<PlaceCubit>(context).getAllPlaces();
            },
          );
        },
        child: BlocConsumer<PlaceCubit, PlaceState>(
          listener: (context, state) {
            state.whenOrNull(
              initialState: () {
                context.loaderOverlay.hide();
              },
              errorState: (message) {
                context.loaderOverlay.hide();
                buildErrorCustomSnackBar(
                  context,
                  'Что то не так, пожалуйста повторите заново',
                );
              },
              loadedAllState: (places) {
                context.loaderOverlay.hide();
                placeList = places;
              },
              loadedOneState: (place) {
                context.loaderOverlay.hide();
                BlocProvider.of<PlaceCubit>(context).getAllPlaces();
              },
              loadingState: () {
                context.loaderOverlay.show();
              },
            );
          },
          builder: (context, state) {
            return SizedBox(
              height: context.screenSize.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SmartRefresher(
                        // enablePullUp: true,
                        header: refreshClassicHeader(context),
                        footer: refreshClassicFooter(context),
                        controller: refreshController,
                        onRefresh: () {
                          BlocProvider.of<PlaceCubit>(context)
                              .getAllPlaces()
                              .whenComplete(
                                () => refreshController.refreshCompleted(),
                              );
                        },
                        scrollController: scrollController,
                        child: CustomScrollView(
                          cacheExtent: 10000,
                          controller: scrollController,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.grid_view_rounded,
                                        color: AppColors.kMainGreen,
                                        size: 40,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: AppColors.kMainGreen,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                          'assets/png/main_profile.png',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        context.repository.authRepository.user!
                                            .name,
                                        style: AppTextStyles.os20w500,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                          left: 10,
                                        ),
                                        child:
                                            Image.asset('assets/png/hand.png'),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    context.repository.authRepository.user!
                                        .region.name,
                                    style: AppTextStyles.os14w500GreyNeutral,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // IconButton(
                                  //     onPressed: () async {
                                  //       await showSearch(
                                  //         context: context,
                                  //         delegate: CustomSearchDelegate(),
                                  //       );
                                  //     },
                                  //     icon: Icon(Icons.abc)),
                                  GestureDetector(
                                    // behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      await showSearch(
                                        context: context,
                                        delegate: CustomSearchDelegate(
                                          placeList,
                                          searchHistory,
                                          onClearHistory: () {
                                            setState(() {
                                              searchHistory.clear();
                                            });
                                          },
                                        ),
                                      );
                                    },
                                    child: const CommonInput(
                                      'Поиск',
                                      prefixIcon: Icon(
                                        Icons.search_rounded,
                                        color: AppColors.kMainGreen,
                                        size: 35,
                                      ),
                                      editable: false,
                                      style: AppTextStyles.os18w500,
                                      contentPaddingVertical: 14,
                                      contentPaddingHorizontal: 10,
                                      borderRadius: 12,
                                      borderColor: AppColors.kMainGreen,
                                      borderWidth: 1,
                                      isTexthint: true,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      serviceContainers(
                                        'assets/svg/restaurant.svg',
                                        'Еда',
                                        2,
                                        context,
                                      ),
                                      serviceContainers(
                                        'assets/svg/hotel.svg',
                                        'Отель',
                                        3,
                                        context,
                                      ),
                                      serviceContainers(
                                        'assets/svg/camping.svg',
                                        'Туры',
                                        1,
                                        context,
                                      ),
                                      serviceContainers(
                                        'assets/svg/airplane.svg',
                                        'Услуги',
                                        4,
                                        context,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  state.maybeWhen(
                                    loadedAllState: (place) {
                                      return SizedBox(
                                        height: 264,
                                        child: ListView.separated(
                                          //Нужно заменить на сливер листы
                                          // padding: const EdgeInsets.only(left: 16, right: 7),
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: place.length,
                                          // itemExtent: 225,
                                          itemBuilder: (context, index) {
                                            final currentPlace = place[index];
                                            final imageUrl = currentPlace
                                                            .images ==
                                                        [] ||
                                                    currentPlace.images ==
                                                        null ||
                                                    currentPlace.images!.isEmpty
                                                ? 'http://res.cloudinary.com/du3qoyvbx/image/upload/v1716750538/caption.jpg.jpg'
                                                : currentPlace.images![0].url;
                                            // : currentPlace.images![0].url;
                                            // log(currentPlace.images![0].url);
                                            final placeName = currentPlace.name;
                                            final location =
                                                currentPlace.region?.name ??
                                                    'Unknown Location';
                                            final rating =
                                                currentPlace.rating.toString();
                                            return Row(
                                              children: [
                                                bannerSliders(
                                                  imageUrl,
                                                  placeName,
                                                  location,
                                                  rating,
                                                  currentPlace,
                                                  context,
                                                ),
                                              ],
                                            );
                                          },
                                          separatorBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return const SizedBox(width: 18);
                                          },
                                        ),
                                      );
                                    },
                                    // loadingState: () {
                                    //   return SizedBox(
                                    //     height: 264,
                                    //     child: ListView.separated(
                                    //       //Нужно заменить на сливер листы
                                    //       // padding: const EdgeInsets.only(left: 16, right: 7),
                                    //       physics:
                                    //           const BouncingScrollPhysics(),
                                    //       scrollDirection: Axis.horizontal,
                                    //       itemCount: 5,
                                    //       // itemExtent: 225,
                                    //       itemBuilder: (context, index) {
                                    //         return const ShimmerBox(
                                    //           height: 264,
                                    //           width: 225,
                                    //           radius: 12,
                                    //         );
                                    //       },
                                    //       separatorBuilder: (
                                    //         BuildContext context,
                                    //         int index,
                                    //       ) {
                                    //         return const SizedBox(width: 18);
                                    //       },
                                    //     ),
                                    //   );
                                    // },
                                    errorState: (message) {
                                      return SizedBox(
                                        height: 264,
                                        child: ListView.separated(
                                          //Нужно заменить на сливер листы
                                          // padding: const EdgeInsets.only(left: 16, right: 7),
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 5,
                                          // itemExtent: 225,
                                          itemBuilder: (context, index) {
                                            return const ShimmerBox(
                                              height: 264,
                                              width: 225,
                                              radius: 12,
                                            );
                                          },
                                          separatorBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return const SizedBox(width: 18);
                                          },
                                        ),
                                      );
                                    },
                                    orElse: () {
                                      return SizedBox(
                                        height: 264,
                                        child: ListView.separated(
                                          //Нужно заменить на сливер листы
                                          // padding: const EdgeInsets.only(left: 16, right: 7),
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: placeList.length,
                                          // itemExtent: 225,
                                          itemBuilder: (context, index) {
                                            final currentPlace =
                                                placeList[index];
                                            final imageUrl = currentPlace
                                                            .images ==
                                                        [] ||
                                                    currentPlace.images ==
                                                        null ||
                                                    currentPlace.images!.isEmpty
                                                ? 'http://res.cloudinary.com/du3qoyvbx/image/upload/v1716750538/caption.jpg.jpg'
                                                : currentPlace.images![0].url;
                                            // : currentPlace.images![0].url;
                                            // log(currentPlace.images![0].url);
                                            final placeName = currentPlace.name;
                                            final location =
                                                currentPlace.region?.name ??
                                                    'Unknown Location';
                                            final rating =
                                                currentPlace.rating.toString();
                                            return Row(
                                              children: [
                                                bannerSliders(
                                                  imageUrl,
                                                  placeName,
                                                  location,
                                                  rating,
                                                  currentPlace,
                                                  context,
                                                ),
                                              ],
                                            );
                                          },
                                          separatorBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return const SizedBox(width: 18);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  // SizedBox(
                                  //   height: 264,
                                  //   child: ListView.separated(
                                  //     //Нужно заменить на сливер листы
                                  //     // padding: const EdgeInsets.only(left: 16, right: 7),
                                  //     physics: const BouncingScrollPhysics(),
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemCount: 5,
                                  //     // itemExtent: 225,
                                  //     itemBuilder: (context, index) {
                                  //       return Row(
                                  //         children: [
                                  //           bannerSliders(
                                  //             data.values.elementAt(0).toString(),
                                  //             data.values.elementAt(1).toString(),
                                  //             data.values.elementAt(2).toString(),
                                  //             data.values.elementAt(3).toString(),
                                  //             context,
                                  //           ),
                                  //         ],
                                  //       );
                                  //     },
                                  //     separatorBuilder:
                                  //         (BuildContext context, int index) {
                                  //       return const SizedBox(width: 18);
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget serviceContainers(
    String picturePath,
    String data,
    int index,
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: () {
          _updateList(index);
        },
        child: Column(
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
              style:
                  AppTextStyles.os12w500.copyWith(color: AppColors.kMainGreen),
            ),
          ],
        ),
      );

  Widget bannerSliders(
    String picturePath,
    String? placeName,
    String? location,
    String? rating,
    PlaceDTO place,
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: () => context.router.push(ProductRoute(place: place)),
        child: Container(
          // height: context.screenSize.height * 0.33,
          // width: context.screenSize.width * 0.575,
          height: 264,
          width: 207,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.kMainGreen),
            image: DecorationImage(
              image: NetworkImage(picturePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  BlocProvider.of<FavoriteCubit>(context)
                      .likeProduct(id: place.id.toString());
                },
                child: saveButton(context, place.liked),
              ),
              const Spacer(),
              Text(
                placeName ?? 'Place',
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
                    location ?? 'location',
                    style: AppTextStyles.os14w400
                        .copyWith(color: AppColors.kMainGreen),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.star_rounded,
                    color: AppColors.kMainGreen,
                    size: 10,
                  ),
                  Text(
                    rating ?? 'rating',
                    style: AppTextStyles.os12w500
                        .copyWith(color: AppColors.kWhite),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget saveButton(BuildContext context, bool liked) => Container(
        height: 35,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.kMainGreen),
          color: AppColors.kWhite,
        ),
        child: Icon(
          !liked ? Icons.bookmark_border_rounded : Icons.bookmark,
          size: 20,
          color: AppColors.kMainGreen,
        ),
      );
}
