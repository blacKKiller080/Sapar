import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/helper/input_helper.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/bloc/app_bloc.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/base_app_bar.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/common_input.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_checkbox.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_snackbars.dart';
import 'package:sapar/src/features/auth/bloc/login_cubit.dart';
import 'package:sapar/src/features/auth/model/record_dto.dart';

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
  MaskTextInputFormatter formatter = InputHelper.maskTextInputFormatter();

  String sex = 'male';

  List<RecordDTO> regions = [];

  RecordDTO? dropdownvalue;

  DateTime? _selectedDate;

  String? _selectedDateFormat;

  Future<void> _selectDate(BuildContext context) async {
    final format = DateFormat('dd-MM-yyyy');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedDateFormat = format.format(picked);
      });
    }
  }

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
    BlocProvider.of<LoginCubit>(context).getRegion();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          initialState: () {
            context.loaderOverlay.hide();
          },
          loadingState: () {
            context.loaderOverlay.show();
          },
          regionState: (region) {
            log('regions loaded');
            regions = region;
            setState(() {
              if (regions.isNotEmpty) {
                dropdownvalue = regions.first;
              }
            });
            if (region.isNotEmpty) {
              for (final i in region) {
                log('Installed regions successfully: \n ${i.name}');
              }
            }
          },
          tokenState: (accessToken) {
            context.loaderOverlay.hide();

            BlocProvider.of<LoginCubit>(context).getUser();
            log('Log from token state in login page');
          },
          loadedState: (user) {
            context.loaderOverlay.hide();
            context.appBloc.add(const AppEvent.logining());
            context.router
                .popUntil((route) => route.settings.name == LauncherRoute.name);
          },
          errorState: (message, iinMessage, passwordMessage) {
            context.loaderOverlay.hide();
            buildErrorCustomSnackBar(context, message);
          },
        );
      },
      builder: (context, state) {
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
                      const BaseAppBar(title: 'Регистрация аккаунта'),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Дата рождения',
                            style: AppTextStyles.os15w500,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Text(
                              _selectedDate == null
                                  ? 'Выберите дату'
                                  : '$_selectedDateFormat',
                              style: AppTextStyles.os15w500,
                            ),
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
                            onTap: () {
                              setState(() {
                                sex = 'male';
                              });
                            },
                            child: Text(
                              'Мужской',
                              style: TextStyle(
                                color:
                                    sex == 'male' ? Colors.green : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                sex = 'female';
                              });
                            },
                            child: Text(
                              'Женский',
                              style: TextStyle(
                                color: sex == 'female'
                                    ? Colors.green
                                    : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Icon(Icons.location_city),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Text(
                                  'Ваш регион',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          items: regions
                              .map(
                                (region) => DropdownMenuItem<RecordDTO>(
                                  value: region,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_city,
                                        color: AppColors.kMainGreen,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        region.name,
                                        style: AppTextStyles.os14w600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          value: dropdownvalue,
                          onChanged: (value) {
                            setState(() {
                              dropdownvalue = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.only(
                              right: 16,
                              top: 6,
                              bottom: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.kWhite,
                              border: Border.all(color: AppColors.kMainGreen),
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.kGreen,
                            ),
                            iconSize: 30,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            // width: 600,
                            offset: const Offset(0, -10),
                            isFullScreen: true,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 16),
                          ),
                        ),
                      ),
                      // state.maybeWhen(
                      //   regionState: (region) {
                      //     return DropdownButton<String>(
                      //       value: dropdownvalue,
                      //       icon: const Icon(Icons.keyboard_arrow_down),
                      //       items: regions.map((RecordDTO region) {
                      //         return DropdownMenuItem<String>(
                      //           value: region.name,
                      //           child: Text(region.name),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? newValue) {
                      //         setState(() {
                      //           dropdownvalue = newValue!;
                      //         });
                      //       },
                      //       hint: const Text('Выберите регион'),
                      //     );
                      //   },
                      //   orElse: () => const Text('Выберите регион'),
                      // ),
                      const SizedBox(height: 15),
                      CommonInput(
                        'Номер телефона',
                        controller: numberController,
                        customColor: AppColors.kBlack,
                        type: InputType.NUMBER,
                        textInputAction: TextInputAction.next,
                        borderColor: AppColors.kMainGreen,
                        contentPaddingVertical: 14,
                        borderWidth: 1,
                        formatters: [formatter],
                      ),
                      const SizedBox(height: 15),
                      CommonInput(
                        'Пароль',
                        controller: passwordController,
                        customColor: AppColors.kBlack,
                        type: InputType.PASSWORD,
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
                          BlocProvider.of<LoginCubit>(context).registration(
                            phone: '8${formatter.getUnmaskedText()}',
                            password: passwordController.text,
                            name: loginController.text,
                            surname: surnameController.text,
                            birthDate: '$_selectedDateFormat',
                            sex: sex,
                            region: 1,
                          );
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
      },
    );
  }
}
