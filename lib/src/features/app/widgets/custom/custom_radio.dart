import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';

class CustomRadio extends StatefulWidget {
  final double size;
  final int value;
  final int? groupValue;
  final void Function(int) onChanged;
  final bool checkIcon;
  const CustomRadio({
    super.key,
    required this.value,
    this.groupValue,
    required this.onChanged,
    this.size = 20.0,
    this.checkIcon = true,
  });

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    final bool selected = widget.value == widget.groupValue;

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: widget.size,
        height: widget.size,
        // padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color:
                widget.checkIcon ? const Color(0xffE0E0E0) : AppColors.kBlack,
          ),
        ),

        child: Center(
          child: widget.checkIcon
              ? selected
                  ? Container(
                      height: widget.size,
                      width: widget.size,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00CF8A),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.kWhite,
                        size: 14,
                      ),
                    )
                  : const SizedBox()
              : Container(
                  height: widget.size / 2,
                  width: widget.size / 2,
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
        ),
      ),
    );
  }
}
