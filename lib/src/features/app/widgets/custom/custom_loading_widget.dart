import 'package:flutter/material.dart';
import 'package:flutter_wrap_architecture/src/core/resources/resources.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CustomLoadingWidget extends StatelessWidget {
  final bool isError;
  final Widget child;
  final double size;
  const CustomLoadingWidget({
    super.key,
    this.isError = false,
    this.size = 100,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.4),
      useDefaultLoading: false,
      overlayWidget: Center(
        child: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            strokeWidth: 2,
            color: isError ? AppColors.kRed : AppColors.kMainGreen,
          ),
        ),
      ),
      child: child,
    );
  }
}
