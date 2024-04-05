import 'package:flutter/material.dart';
import 'package:sapar/src/core/extension/extensions.dart';
import 'package:sapar/src/core/resources/resources.dart';

class ContactBottomSheet extends StatefulWidget {
  const ContactBottomSheet({
    super.key,
  });

  static Future<void> show(
    BuildContext context,
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
      builder: (_) => const ContactBottomSheet(),
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
          const Text(
            '+ 7 777 777 77 77',
            style: AppTextStyles.os12w400,
          ),
          const Text(
            '+ 7 777 777 77 77',
            style: AppTextStyles.os12w400,
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Whats’App',
                style: AppTextStyles.os15w500,
              ),
              Icon(Icons.support_agent_outlined),
            ],
          ),
          const Text(
            '+ 7 777 777 77 77',
            style: AppTextStyles.os12w400,
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Instagram',
                style: AppTextStyles.os15w500,
              ),
              Icon(Icons.abc),
            ],
          ),
          Text(
            '@shafran_cafe',
            style: AppTextStyles.os15w400GreyNeutral
                .copyWith(color: AppColors.kBlack),
          ),
        ],
      ),
    );
  }
}
