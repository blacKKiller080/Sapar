import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/app_bar_with_title.dart';
import 'package:sapar/src/features/app/widgets/base_app_bar.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/common_input.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_checkbox.dart';

@RoutePage()
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

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
    return Scaffold(
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
                right: 25,
                left: 25,
              ),
              child: Column(
                children: [
                  const AppBarWithTitle(title: 'Регистрация аккаунта'),
                  SizedBox(height: context.screenSize.height * 0.05),
                  CommonInput(
                    'Имя',
                    controller: loginController,
                    customColor: AppColors.kBlack,
                    contentPaddingVertical: 14,
                    textInputAction: TextInputAction.next,
                    borderColor: AppColors.kMainGreen,
                    borderWidth: 1,
                  ),
                  const SizedBox(height: 15),
                  CommonInput(
                    'Фамилия',
                    controller: surnameController,
                    customColor: AppColors.kBlack,
                    textInputAction: TextInputAction.next,
                    contentPaddingVertical: 14,
                    borderColor: AppColors.kMainGreen,
                    borderWidth: 1,
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      Text(
                        'Дата рождения',
                        style: AppTextStyles.os15w500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Ваш пол',
                        style: AppTextStyles.os15w500,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Мужской',
                          style: AppTextStyles.os12w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Женский',
                          style: AppTextStyles.os12w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CommonInput(
                    'Ваш регион',
                    controller: loginController,
                    customColor: AppColors.kBlack,
                    contentPaddingVertical: 14,
                    textInputAction: TextInputAction.next,
                    borderColor: AppColors.kMainGreen,
                    borderWidth: 1,
                  ),
                  const SizedBox(height: 15),
                  CommonInput(
                    'Логин или номер телефона',
                    controller: numberController,
                    type: InputType.PASSWORD,
                    customColor: AppColors.kBlack,
                    textInputAction: TextInputAction.next,
                    contentPaddingVertical: 14,
                    borderColor: AppColors.kMainGreen,
                    borderWidth: 1,
                  ),
                  const SizedBox(height: 15),
                  CommonInput(
                    'Пароль',
                    controller: passwordController,
                    customColor: AppColors.kBlack,
                    contentPaddingVertical: 14,
                    textInputAction: TextInputAction.done,
                    borderColor: AppColors.kMainGreen,
                    borderWidth: 1,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Я соглащаюсь с условями',
                        style: AppTextStyles.os13w400,
                      ),
                      const SizedBox(width: 5),
                      CustomCheckbox(isSelect: false, onTap: () {}),
                    ],
                  ),
                  CommonButton(
                    onPressed: () {
                      // context.appBloc.add()
                      context.router.pop();
                    },
                    margin: const EdgeInsets.only(
                      top: 25,
                      bottom: 16,
                    ),
                    child: const Text('Зарегистрироваться'),
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
