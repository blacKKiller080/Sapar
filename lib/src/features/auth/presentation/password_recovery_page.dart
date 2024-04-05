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
class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  TextEditingController loginController = TextEditingController();

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
                  const AppBarWithTitle(title: 'Восстановление аккаунта'),
                  SizedBox(height: context.screenSize.height * 0.05),
                  const Text(
                    'Введите логин или номер телефона, мы отправим код подтверждения для восстановление аккаунта',
                    style: AppTextStyles.os12w400,
                  ),
                  CommonInput(
                    'Логин или номер телефона',
                    controller: loginController,
                    type: InputType.PASSWORD,
                    customColor: AppColors.kBlack,
                    textInputAction: TextInputAction.next,
                    contentPaddingVertical: 14,
                    borderColor: AppColors.kMainGreen,
                    borderWidth: 1,
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
