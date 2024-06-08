import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/app_bar_with_title.dart';
import 'package:sapar/src/features/auth/model/plan_dto.dart';
import 'package:sapar/src/features/client/main_page/bloc/plan_cubit.dart';

@RoutePage()
class PlannedToursPage extends StatefulWidget {
  const PlannedToursPage({super.key});

  @override
  State<PlannedToursPage> createState() => _PlannedToursPageState();
}

class _PlannedToursPageState extends State<PlannedToursPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PlanCubit>(context).getPlans();
  }

  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController = RefreshController();
  List<PlanDTO>? planDTO;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanCubit, PlanState>(
      listener: (context, state) {
        state.whenOrNull(
          loadedAllPlans: (plans) {
            planDTO = plans;
          },
        );
      },
      child: Scaffold(
        body: SizedBox(
          height: context.screenSize.height,
          child: Column(
            children: [
              //  Expanded(
              //   child: SmartRefresher(
              //     // enablePullUp: true,
              //     header: refreshClassicHeader(context),
              //     footer: refreshClassicFooter(context),
              //     controller: refreshController,
              //     onRefresh: () {
              //       BlocProvider.of<PlanCubit>(context).getPlans().whenComplete(
              //             () => refreshController.refreshCompleted(),
              //           );
              //     },
              //     scrollController: scrollController,
              //     child: CustomScrollView(
              //       cacheExtent: 10000,
              //       controller: scrollController,
              //       keyboardDismissBehavior:
              //           ScrollViewKeyboardDismissBehavior.onDrag,
              //       slivers: [
              //         SliverList(
              //           delegate: SliverChildListDelegate(
              //             [
              const AppBarWithTitle(title: 'План поездки'),
              BlocBuilder<PlanCubit, PlanState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loadedAllPlans: (plans) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: plans.length,
                          itemBuilder: (context, index) {
                            return item1(plans[index]);
                          },
                        ),
                      );
                    },
                    loadingState: () {
                      return planDTO != null
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: planDTO!.length,
                                itemBuilder: (context, index) {
                                  return item1(planDTO![index]);
                                },
                              ),
                            )
                          : const SizedBox.shrink();
                      // ShimmerBox(
                      //   height: 60,
                      //   width: context.screenSize.width * 0.8,
                      //   radius: 12,
                      // );
                    },
                    orElse: () {
                      return planDTO != null
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: planDTO!.length,
                                itemBuilder: (context, index) {
                                  return item1(planDTO![index]);
                                },
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  );
                },
              ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //          ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item1(PlanDTO planDTO) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kSecondaryGray,
        ),
        padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6, right: 6),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    planDTO.place.images!.isEmpty
                        ? 'http://res.cloudinary.com/du3qoyvbx/image/upload/v1716750538/caption.jpg.jpg'
                        : planDTO.place.images!.first.url,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      planDTO.place.name,
                      style: AppTextStyles.os15w500.copyWith(
                        color: AppColors.kMainGreen,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 3,
                    ),
                    Text(
                      planDTO.place.region!.name,
                      style: AppTextStyles.os13w500,
                    ),
                  ],
                ),
              ),
            ),
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'Кокжайлау\n',
            //         style: AppTextStyles.os15w500
            //             .copyWith(color: AppColors.kMainGreen),
            //       ),
            //       const TextSpan(text: 'Алматы', style: AppTextStyles.os13w500),
            //     ],
            //   ),
            // ),

            SizedBox(
              height: 85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<PlanCubit>(context).getPlans();
                    },
                    child: const Icon(
                      Icons.more_vert,
                      size: 30,
                      color: AppColors.kMainGreen,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '${planDTO.date.day}.${planDTO.date.month}.${planDTO.date.year}',
                      style: AppTextStyles.os12w400,
                    ),
                  ),
                ],
              ),
            ),
            // const Icon(
            //   Icons.more_vert,
            //   color: AppColors.kMainGreen,
            //   size: 30,
            // ),
          ],
        ),
      );

//   Widget item(PlanDTO planDTO) => Container(
//         margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 6),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: AppColors.kSecondaryGray,
//         ),
//         padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6),
//         child: Row(
//           children: [
//             const Icon(
//               Icons.location_on,
//               color: AppColors.kMainGreen,
//             ),
//             const SizedBox(width: 8),
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'Кокжайлау\n',
//                     style: AppTextStyles.os15w500
//                         .copyWith(color: AppColors.kMainGreen),
//                   ),
//                   const TextSpan(text: 'Алматы', style: AppTextStyles.os13w500),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             const Align(
//               alignment: Alignment.bottomCenter,
//               child: Text(
//                 '10.07.2023',
//                 style: AppTextStyles.os10w500,
//               ),
//             ),
//             const Icon(
//               Icons.more_vert,
//               color: AppColors.kMainGreen,
//               size: 30,
//             ),
//           ],
//         ),
//       );
}
