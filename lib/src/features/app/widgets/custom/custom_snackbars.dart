import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    buildSuccessCustomSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 6.0,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: const Color(0xff009C73),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    buildErrorCustomSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 6.0,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    ),
  );
}

ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
    buildTopBanner(
  BuildContext context,
  String message, {
  Color color = Colors.red,
}) {
  return ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      content: Row(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
      overflowAlignment: OverflowBarAlignment.start,
      // leading: const Icon(Icons.info),
      // padding: const EdgeInsets.only(right: 16, left: 16, top: 20),
      backgroundColor: color,
      actions: [
        TextButton(
          child: const Text(
            'Закрыть',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () =>
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
        ),
      ],
    ),
  );
}
