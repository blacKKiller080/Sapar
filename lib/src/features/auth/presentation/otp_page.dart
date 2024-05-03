import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/app_bar_with_title.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_back_button.dart';

@RoutePage()
class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController pinputController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();

  bool onReady = false;
  int _start = 59;
  bool enableTimer = false;
  String tokenCode = '';

  @override
  void initState() {
    super.initState();
    startTimer();
    pinputController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    pinputController.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (!mounted) return;
        if (_start == 0) {
          setState(() {
            timer.cancel();
            enableTimer = true;
            onReady = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  final defaultPinTheme = const PinTheme(
    width: 48,
    height: 48,
    textStyle: TextStyle(
      color: AppColors.kMainGreen,
      fontWeight: FontWeight.w600,
      fontSize: 40,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: context.mediaQuery.viewInsets.bottom,
                right: 25,
                left: 25,
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  SizedBox(height: context.screenSize.height * 0.1),
                  const AppBarWithTitle(title: 'Восстановление аккаунта'),
                  SizedBox(height: context.screenSize.height * 0.05),
                  SizedBox(
                    width: context.screenSize.width * 0.7,
                    child: const Text(
                      'Код отправлен на ваш email nurdaulet123@mail.ru',
                      style: AppTextStyles.os12w400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    child: Pinput(
                      autofocus: true,
                      controller: pinputController,
                      // separatorBuilder: (index) => const SizedBox(
                      //   width: 40,
                      // ),
                      closeKeyboardWhenCompleted: false,
                      preFilledWidget: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.kWhite,
                          border: Border.all(
                            width: 2,
                            color: AppColors.kMainGreen,
                          ),
                        ),
                      ),
                      obscuringWidget: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.kWhite,
                          border: Border.all(
                            width: 2,
                            color: AppColors.kMainGreen,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '*',
                            style: AppTextStyles.os32w700.copyWith(height: 1.8),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      obscureText: true,
                      onSubmitted: (String pin) {
                        log(pinputController.text);
                        if (pinputController.text.length == 4) {
                          if (pinputController.text == '1111') {
                            // widget.isVerificationNewUser
                            //     ? BlocProvider.of<NewUserVerificationCubit>(
                            //             context)
                            //         .verificateUser(
                            //   email: widget.email,
                            //         code: pinputController.text,
                            //       )
                            //     : BlocProvider.of<PasswordRecoveryCubit>(
                            //             context)
                            //         .checkCode(
                            //         code: pinputController.text,
                            //         token: tokenCode,
                            //       );
                          }
                          FocusScope.of(context).unfocus();
                        }
                        setState(() {});
                      },
                      onChanged: (String pin) {
                        log(pinputController.text);
                        if (pinputController.text.length == 4) {
                          FocusScope.of(context).unfocus();
                        }
                        setState(() {});
                      },

                      defaultPinTheme: defaultPinTheme,
                      submittedPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme,
                      followingPinTheme: defaultPinTheme,
                    ),
                  ),
                  const SizedBox(height: 42),
                  if (onReady)
                    Align(
                      child: TextButton(
                        onPressed: () {
                          if (onReady) {
                            setState(() {
                              enableTimer = false;
                              _start = 90;
                              onReady = false;
                            });
                            startTimer();
                          }
                        },
                        child: Text(
                          'Повторно запросить код',
                          style: AppTextStyles.os16w600
                              .copyWith(color: AppColors.kMainGreen),
                        ),
                      ),
                    )
                  else
                    Text.rich(
                      TextSpan(
                        text: 'Код истекает через ',
                        style: AppTextStyles.os16w600,
                        children: [
                          TextSpan(
                            text:
                                '00:${_start % 60 < 10 ? '0' : (_start % 60).toString()} ',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: AppTextStyles.os16w600,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  CommonButton(
                    onPressed: () {
                      // context.appBloc.add()
                      // context.router.push(const OtpRoute());
                    },
                    margin: const EdgeInsets.only(
                      top: 25,
                      bottom: 16,
                    ),
                    child: const Text('Подтвердить'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
