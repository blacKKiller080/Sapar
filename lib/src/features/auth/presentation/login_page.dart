import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/helper/input_helper.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/bloc/app_bloc.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/common_input.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_snackbars.dart';
import 'package:sapar/src/features/auth/bloc/login_cubit.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   _focusNode.dispose();

  //   super.dispose();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          initialState: () {
            context.loaderOverlay.hide();
          },
          loadingState: () {
            context.loaderOverlay.show();
          },
          regionState: (region) => context.loaderOverlay.hide(),
          tokenState: (accessToken) {
            context.loaderOverlay.hide();

            BlocProvider.of<LoginCubit>(context).getUser();
            log('Log from token state in login page');
          },
          loadedState: (user) {
            context.loaderOverlay.hide();
            context.appBloc.add(const AppEvent.logining());
          },
          errorState: (message, iinMessage, passwordMessage) {
            context.loaderOverlay.hide();
            buildErrorCustomSnackBar(context, message);
          },
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: context.mediaQuery.viewInsets.bottom,
                  top: 25,
                ),
                child: Column(
                  children: [
                    Container(
                      height: context.screenSize.width / 2,
                      width: context.screenSize.width / 2,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/png/logo_big.png',
                            // height: 25,
                          ),
                        ),
                      ),
                    ),
                    // const AppBarWithTitle(title: 'Login Page'),
                    SizedBox(height: context.screenSize.height * 0.05),

                    CommonInput(
                      'Логин',
                      margin: const EdgeInsets.only(right: 16, left: 16),
                      controller: loginController,
                      customColor: AppColors.kBlack,
                      contentPaddingVertical: 14,
                      type: InputType.NUMBER,
                      textInputAction: TextInputAction.next,
                      borderColor: AppColors.kMainGreen,
                      borderWidth: 1,
                      formatters: [formatter],
                    ),
                    CommonInput(
                      'Пароль',
                      margin:
                          const EdgeInsets.only(right: 16, left: 16, top: 30),
                      controller: passwordController,
                      type: InputType.PASSWORD,
                      customColor: AppColors.kBlack,
                      textInputAction: TextInputAction.done,
                      contentPaddingVertical: 14,
                      borderColor: AppColors.kMainGreen,
                      borderWidth: 1,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        context.router.push(const PasswordRecoveryRoute());
                      },
                      child: const Text(
                        'Забыли пароль?',
                        style: AppTextStyles.os13w400,
                      ),
                    ),
                    CommonButton(
                      onPressed: () {
                        // context.router.push(const MainRoute());

                        BlocProvider.of<LoginCubit>(context).login(
                          login: '8${formatter.getUnmaskedText()}',
                          password: passwordController.text,
                        );
                      },
                      margin: const EdgeInsets.only(
                        top: 25,
                        right: 16,
                        left: 16,
                        bottom: 16,
                      ),
                      child: const Text('Авторизация'),
                    ),
                    const Text(
                      'или',
                      style: AppTextStyles.os13w400,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/png/google.png'),
                        Image.asset('assets/png/facebook.png'),
                        Image.asset('assets/png/apple.png'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'У вас нет аккаунта?',
                          style: AppTextStyles.os12w400.copyWith(
                            color: AppColors.kTextSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            context.router.push(const RegistrationRoute());
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.kMainGreen,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Зарегистрироваться',
                              style: AppTextStyles.os12w600Green,
                            ),
                          ),
                        ),
                      ],
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
