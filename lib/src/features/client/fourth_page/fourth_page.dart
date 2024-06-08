import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/bloc/app_bloc.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/base_app_bar.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_circle_button.dart';
import 'package:sapar/src/features/client/fourth_page/bloc/profile_bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    // context.profileBloc.add(const ProfileEvent.getProfile());

    log('initProfile');
  }

  File? image;
  final picker = ImagePicker();

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBLoC, ProfileState>(
      listener: (context, state) {
        BlocListener<ProfileBLoC, ProfileState>(
          listener: (context, state) {
            state.whenOrNull(
              loadingState: () {},
              loadedState: (user) {},
              errorState: (String message) {
                // buildErrorCustomSnackBar(context, message);
                log(message);
              },
              exitedState: () {
                context.appBloc.add(const AppEvent.exiting());
              },
            );
          },
        );
      },
      builder: (context, state) {
        return Column(
          children: [
            BaseAppBar(
              title: 'Профиль',
              trailing: GestureDetector(
                onTap: () {
                  context.router.push(
                    SettingsRoute(
                      user: context.repository.authRepository.user!,
                    ),
                  );
                  // state.maybeWhen(
                  //   loadedState: (user) async {
                  //     context.router.push(SettingsRoute(user: user));
                  //   },
                  //   errorState: (message) {
                  //     buildErrorCustomSnackBar(context, message);
                  //   },
                  //   orElse: () {},
                  // );
                },
                child: const Icon(
                  Icons.settings,
                  size: 30,
                  color: AppColors.kMainGreen,
                ),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                getImageFromGallery();
              },
              child: CircleAvatar(
                backgroundColor: AppColors.kMainGreen,
                radius: 60,
                foregroundImage: image != null
                    ? FileImage(image!)
                    : const AssetImage('assets/png/test_profile.jpg')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              context.repository.authRepository.user!.name,
              style: AppTextStyles.os20w500,
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCircleButton(
                  onTap: () {},
                  border: true,
                  elevation: 0,
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.kMainGreen,
                  ),
                ),
                const SizedBox(width: 20),
                CustomCircleButton(
                  onTap: () {
                    context.router.push(const BookMarksRoute());
                  },
                  border: true,
                  elevation: 0,
                  child: const Icon(
                    Icons.bookmark,
                    color: AppColors.kMainGreen,
                  ),
                ),
                const SizedBox(width: 20),
                CustomCircleButton(
                  onTap: () {},
                  border: true,
                  elevation: 0,
                  child: const Icon(
                    Icons.calendar_today,
                    color: AppColors.kMainGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              'Фотографии',
              style: AppTextStyles.os20w600,
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imageContainer(),
                    const SizedBox(width: 9),
                    imageContainer(),
                    const SizedBox(width: 9),
                    imageContainer(),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imageContainer(),
                    const SizedBox(width: 9),
                    imageContainer(),
                    const SizedBox(width: 9),
                    imageContainer(),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget imageContainer() => SizedBox(
        height: 80,
        width: 80,
        child: Image.asset('assets/png/image_container.png'),
      );
}
