import 'package:flutter/material.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/auth/model/contact_dto.dart';

class ContactBottomSheet extends StatefulWidget {
  final Contacts contacts;
  const ContactBottomSheet({
    super.key,
    required this.contacts,
  });

  static Future<void> show(
    BuildContext context,
    Contacts contacts,
  ) async {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: false,
      backgroundColor: AppColors.kWhite,
      barrierColor: Colors.black.withOpacity(0.25),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (_) => ContactBottomSheet(contacts: contacts),
    );
  }

  @override
  _ContactBottomSheetState createState() => _ContactBottomSheetState();
}

class _ContactBottomSheetState extends State<ContactBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15.0,
        bottom: context.mediaQuery.viewPadding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 34,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Телефоны',
                style: AppTextStyles.os15w500,
              ),
              Icon(Icons.phone),
            ],
          ),
          Text(
            widget.contacts.phone ?? 'Пусто',
            style: AppTextStyles.os12w400,
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Website',
                style: AppTextStyles.os15w500,
              ),
              Icon(Icons.language),
            ],
          ),
          Text(
            widget.contacts.site ?? 'Пусто',
            style: AppTextStyles.os12w400,
          ),
          const SizedBox(height: 8),
          // const Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       'Instagram',
          //       style: AppTextStyles.os15w500,
          //     ),
          //     Icon(Icons.abc),
          //   ],
          // ),
          // Text(
          //   widget.contacts.insta ?? 'Пусто',
          //   style: AppTextStyles.os15w400GreyNeutral
          //       .copyWith(color: AppColors.kBlack),
          // ),
        ],
      ),
    );
  }
}
