import 'package:flutter/material.dart';

import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/widgets/custom/common_button.dart';

Future<void> planDialog(BuildContext context) async {
  int itemCount = 0;
  final divider = Container(
    height: MediaQuery.of(context).size.height / 100 * 2.789,
    decoration: const BoxDecoration(
      border: Border(
        right: BorderSide(color: AppColors.kGrey, width: .45),
      ),
    ),
  );
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      insetPadding: const EdgeInsets.only(bottom: 100),
      child: StatefulBuilder(
        builder: (context, innerSetState) {
          return Container(
            constraints:
                BoxConstraints(maxWidth: context.screenSize.width * 0.8),
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
                const Row(
                  children: [
                    Text(
                      'Место',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.os15w400GreyNeutral,
                    ),
                    Spacer(),
                    Text(
                      'Кокжайлау',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.os15w500,
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                const Row(
                  children: [
                    Text(
                      'Город',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.os15w400GreyNeutral,
                    ),
                    Spacer(),
                    Text(
                      'Алматы',
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
                          innerSetState(() {
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
                          innerSetState(() {
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
                      onTap: () {},
                      child: const Text(
                        '01.',
                        textAlign: TextAlign.center,
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
                    calendarDialog(context);
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
          );
        },
      ),
    ),
  );
}

Future<void> calendarDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      insetPadding: const EdgeInsets.only(bottom: 100),
      child: StatefulBuilder(
        builder: (context, innerSetState) {
          return Container(
            constraints:
                BoxConstraints(maxWidth: context.screenSize.width * 0.8),
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
                // SfCalendar(
                //   view: CalendarView.week,
                //   // by default the month appointment display mode set as Indicator, we can
                //   // change the display mode as appointment using the appointment display
                //   // mode property
                // ),
                const SizedBox(height: 45),
                CommonButton(
                  onPressed: () {},
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
          );
        },
      ),
    ),
  );
}
