import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapar/src/core/resources/resources.dart';

class CommonInput extends StatefulWidget {
  final String text;
  final String? errorText;

  final InputType type;
  final bool isLabelTextOn;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final void Function(String value)? onChanged;
  final int? maxLines;
  final bool editable;
  final bool readOnly;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final Color customColor;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final Color oscuredIconColor;
  final void Function(String value)? onSubmitted;
  final EdgeInsets? margin;
  final double contentPaddingVertical;
  final double contentPaddingHorizontal;
  final double borderRadius;
  final BorderRadius? isCustomBorderRadius;
  final bool isCenterTitle;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final double borderWidth;
  final String? obscuringCharacter;
  final TextStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final bool? isTexthint;
  final double labelPadding;

  const CommonInput(
    this.text, {
    this.type = InputType.TEXT,
    this.controller,
    this.isLabelTextOn = false,
    this.validator,
    this.formatters,
    this.onChanged,
    this.maxLines,
    this.initialValue,
    this.editable = true,
    this.customColor = AppColors.kTextSecondary,
    this.fillColor = Colors.white,
    this.borderColor = Colors.white,
    this.textColor = AppColors.kBlack,
    this.onSubmitted,
    this.margin,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPaddingVertical = 22,
    this.contentPaddingHorizontal = 16,
    this.borderRadius = 16,
    this.isCenterTitle = false,
    this.oscuredIconColor = AppColors.kMainGreen,
    this.textInputAction,
    this.borderWidth = 0.0,
    this.obscuringCharacter,
    this.style = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    this.focusNode,
    this.autofocus,
    this.readOnly = false,
    this.isTexthint = false,
    this.errorText,
    this.labelPadding = 40,
    this.isCustomBorderRadius,
  });

  @override
  _CommonInputState createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {
  bool _isTextNotObscured = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isLabelTextOn)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                widget.text,
                style: widget.style!.copyWith(
                  color: widget.customColor,
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          TextFormField(
            autofocus: widget.autofocus ?? false,
            readOnly: widget.readOnly,
            onFieldSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            validator: widget.validator,
            focusNode: widget.focusNode,
            controller: widget.controller,
            style: widget.style!.copyWith(
              color: widget.textColor,
            ),
            textAlign:
                widget.isCenterTitle ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLines ?? 1,
            inputFormatters: _getInputFormatters(),
            keyboardType: _getKeyBoardType(widget.type),
            obscuringCharacter: widget.obscuringCharacter ?? "*",
            obscureText: isPasswordInput() && !_isTextNotObscured ||
                widget.obscuringCharacter != null,
            initialValue: widget.initialValue,
            enabled: widget.editable,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              fillColor: widget.fillColor,
              filled: true,
              suffixIconConstraints: const BoxConstraints(),
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: isPasswordInput()
                  ? Padding(
                      padding: EdgeInsets.only(
                        right: widget.contentPaddingHorizontal,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTextNotObscured = !_isTextNotObscured;
                          });
                        },
                        child: Icon(
                          _isTextNotObscured
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: widget.oscuredIconColor,
                          // color: widget.oscuredIconColor,
                        ),
                      ),
                    )
                  : widget.suffixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ), // add padding to adjust icon
                          child: widget.suffixIcon,
                        )
                      : const SizedBox.shrink(),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: widget.contentPaddingHorizontal,
                        right: 12,
                      ), // add padding to adjust icon
                      child: widget.prefixIcon,
                    )
                  : SizedBox(
                      width: widget.contentPaddingHorizontal,
                    ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.contentPaddingVertical,
                horizontal: widget.contentPaddingHorizontal,
              ),
              // contentPadding:
              //     EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 4),
              floatingLabelStyle: AppTextStyles.os18w500.copyWith(
                color: widget.customColor,
              ),
              label: widget.isTexthint!
                  ? null
                  : Text(
                      widget.text,
                      style: widget.style!.copyWith(color: widget.customColor),
                    ),
              // labelText: widget.isTexthint! ? null : widget.text,
              // labelStyle: widget.style!
              //     .copyWith(color: widget.customColor, height: 0.15),
              hintText: widget.isTexthint! ? widget.text : null,
              hintStyle: widget.style!.copyWith(
                color: widget.customColor,
              ),
              errorText: widget.errorText,
              errorStyle: AppTextStyles.os13w500.copyWith(color: Colors.red),
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widget.borderWidth,
                  color: widget.borderColor,
                ),
                borderRadius: widget.isCustomBorderRadius ??
                    BorderRadius.circular(widget.borderRadius),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widget.borderWidth,
                  color: widget.borderColor,
                ),
                borderRadius: widget.isCustomBorderRadius ??
                    BorderRadius.circular(widget.borderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widget.borderWidth,
                  color: widget.borderColor,
                ),
                borderRadius: widget.isCustomBorderRadius ??
                    BorderRadius.circular(widget.borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: widget.borderWidth,
                  color: widget.borderColor,
                ),
                borderRadius: widget.isCustomBorderRadius ??
                    BorderRadius.circular(widget.borderRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextInputFormatter> _getInputFormatters() {
    return widget.formatters ?? [];
  }

  bool isPasswordInput() {
    return widget.type == InputType.PASSWORD;
  }

  TextInputType _getKeyBoardType(InputType type) {
    TextInputType textType;

    switch (type) {
      case InputType.EMAIL:
        textType = TextInputType.emailAddress;
        break;
      case InputType.NUMBER:
        textType = TextInputType.number;
        break;
      case InputType.NUMBER_WITH_OPTIONS:
        textType =
            const TextInputType.numberWithOptions(decimal: true, signed: true);
        break;
      case InputType.PHONE:
        textType = TextInputType.number;
        break;
      default:
        textType = TextInputType.text;
    }

    return textType;
  }
}

enum InputType {
  TEXT,
  PASSWORD,
  EMAIL,
  NUMBER,
  NUMBER_WITH_OPTIONS,
  PHONE,
  TIME
}
