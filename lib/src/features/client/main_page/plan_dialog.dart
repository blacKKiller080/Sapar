import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';
import 'package:sapar/src/features/app/widgets/custom/custom_snackbars.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';
import 'package:sapar/src/features/client/main_page/bloc/plan_cubit.dart';
import 'package:sapar/src/features/client/main_page/widgets/custom_success_dialog.dart';

class PlanDialog extends StatefulWidget {
  final PlaceDTO placeDTO;
  const PlanDialog({super.key, required this.placeDTO});

  static Future<void> show(
    BuildContext context,
    PlaceDTO placeDTO,
  ) async {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.25),
      builder: (_) => PlanDialog(placeDTO: placeDTO),
    );
  }

  @override
  State<PlanDialog> createState() => _PlanDialogState();
}

class _PlanDialogState extends State<PlanDialog> {
  int itemCount = 0;

  DateTime? selectedDate;

  String selectedDateFormat = '';

  Future<void> selectDate(BuildContext context) async {
    final format = DateFormat('MM-dd-yyyy');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateFormat = format.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final divider = Container(
      height: context.screenSize.height / 100 * 2.789,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: AppColors.kGrey, width: .45),
        ),
      ),
    );
    return BlocListener<PlanCubit, PlanState>(
      listener: (context, state) {
        state.whenOrNull(
          loadedState: (statusCode) {
            context.router
                .popUntil((route) => route.settings.name == ProductRoute.name);
            CustomSuccessDialog.show(
              context,
              'Вы успешно запланировали поездку в ${widget.placeDTO.name}',
            );
            BlocProvider.of<PlanCubit>(context).getPlans();
          },
          errorState: (message) {
            buildErrorCustomSnackBar(
              context,
              'Что то не так, пожалуйста повторите',
            );
          },
        );
      },
      child: Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        insetPadding: const EdgeInsets.only(bottom: 100),
        child: Container(
          constraints: BoxConstraints(maxWidth: context.screenSize.width * 0.8),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.only(
            top: 20,
            right: 16,
            left: 16,
            bottom: 25,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SvgPicture.asset('assets/icons/alert.svg'),
              const Text(
                'Планировать',
                textAlign: TextAlign.center,
                style: AppTextStyles.os18w500,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Text(
                    'Место',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.os15w400GreyNeutral,
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      widget.placeDTO.name,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.os15w500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  const Text(
                    'Город',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.os15w400GreyNeutral,
                  ),
                  const Spacer(),
                  Text(
                    widget.placeDTO.region!.name,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.os15w500,
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  const Text(
                    'Кол.Человека',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.os15w400GreyNeutral,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 10.3,
                    child: GestureDetector(
                      // behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (itemCount == 0) {
                          return;
                        }
                        setState(() {
                          itemCount--;
                        });
                      },

                      child: const Text(
                        '-',
                        style: AppTextStyles.os16w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  divider,
                  SizedBox(
                    width: 25,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '$itemCount',
                        style: AppTextStyles.os14w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  divider,
                  //Plus
                  SizedBox(
                    width: 10.3,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          itemCount++;
                        });
                      },
                      child: const Text(
                        '+',
                        style: AppTextStyles.os16w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text(
                    'Дата ',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.os15w400GreyNeutral,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      selectDate(context);
                    },
                    child: Text(
                      selectedDate == null
                          ? 'Выберите дату'
                          : '$selectedDateFormat',
                      style: AppTextStyles.os15w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Text(
                    'Примерный расход',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.os15w400GreyNeutral,
                  ),
                  Spacer(),
                  Text(
                    '20 - 25 000',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.os15w500,
                  ),
                ],
              ),
              const SizedBox(height: 45),
              CommonButton(
                onPressed: () {
                  if (itemCount == 0 || selectedDateFormat == '') {
                    buildErrorCustomSnackBar(context, 'Заполните все поля');
                  } else {
                    BlocProvider.of<PlanCubit>(context).createPlan(
                      amount: itemCount,
                      placeId: widget.placeDTO.id,
                      date: selectedDateFormat,
                      status: 'planned',
                    );
                  }
                },
                miniButton: true,
                margin: const EdgeInsets.symmetric(horizontal: 26),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Планировать',
                      style: AppTextStyles.os13w500.copyWith(
                        color: AppColors.kWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
