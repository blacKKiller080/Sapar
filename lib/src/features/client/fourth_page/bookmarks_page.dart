import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/base_app_bar.dart';
import 'package:sapar/src/features/auth/bloc/login_cubit.dart';
import 'package:sapar/src/features/auth/model/favorite_dto.dart';
import 'package:sapar/src/features/auth/model/user_dto.dart';
import 'package:sapar/src/features/client/main_page/bloc/favorite_cubit.dart';

@RoutePage()
class BookMarksPage extends StatefulWidget {
  const BookMarksPage({super.key});

  @override
  State<BookMarksPage> createState() => _BookMarksPageState();
}

class _BookMarksPageState extends State<BookMarksPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<LoginCubit>(context).getUser();
  }

  UserDTO? userDTO;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            state.whenOrNull(
              loadedState: (user) {
                userDTO = user;
              },
            );
          },
        ),
        BlocListener<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            state.whenOrNull(
              loadedState: (favorites) {
                BlocProvider.of<LoginCubit>(context).getUser();
              },
            );
          },
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            const BaseAppBar(title: 'Закладки'),
            const SizedBox(height: 10),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loadedState: (user) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: user.favorites.length,
                        itemBuilder: (context, index) {
                          return item(user.favorites[index]);
                        },
                      ),
                    );
                  },
                  loadingState: () {
                    return userDTO != null
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: userDTO!.favorites.length,
                              itemBuilder: (context, index) {
                                return item(userDTO!.favorites[index]);
                              },
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                  orElse: () {
                    return userDTO != null
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: userDTO!.favorites.length,
                              itemBuilder: (context, index) {
                                return item(userDTO!.favorites[index]);
                              },
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                );
              },
            ),
            // item(),
          ],
        ),
      ),
    );
  }

  Widget item(Favorite place) => Container(
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
                    place.images!.isEmpty
                        ? 'http://res.cloudinary.com/du3qoyvbx/image/upload/v1716750538/caption.jpg.jpg'
                        : place.images!.last.url,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      place.name,
                      style: AppTextStyles.os15w500.copyWith(
                        color: AppColors.kMainGreen,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 3,
                    ),
                    const Text('Алматы', style: AppTextStyles.os13w500),
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
                      BlocProvider.of<FavoriteCubit>(context)
                          .likeProduct(id: place.id.toString());
                    },
                    child: const Icon(
                      Icons.bookmark,
                      size: 40,
                      color: AppColors.kMainGreen,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColors.kMainGreen,
                      ),
                      Text(' 4.8'),
                    ],
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
}
