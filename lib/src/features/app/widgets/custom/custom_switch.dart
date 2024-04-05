import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';

// ignore: must_be_immutable
class AndroidSwitch extends StatefulWidget {
  bool forAndroid;
  void Function(bool)? onChanged;
  AndroidSwitch({super.key, required this.forAndroid, this.onChanged});

  @override
  State<AndroidSwitch> createState() => _AndroidSwitchState();
}

class _AndroidSwitchState extends State<AndroidSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      // thumb color (round icon)
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

      activeColor: AppColors.kWhite,
      activeTrackColor: AppColors.kTextBrandPrimary,
      inactiveThumbColor: AppColors.kWhite,
      inactiveTrackColor: AppColors.kFoundationGreyLightHover,
      // boolean variable value
      value: widget.forAndroid,
      // changes the state of the switch
      onChanged: widget.onChanged ??
          (value) => setState(() {
                widget.forAndroid = value;
              }),
    );
  }
}

// ignore: must_be_immutable
class CupertinoSwitchButton extends StatefulWidget {
  bool forIos;
  void Function(bool)? onChanged;
  CupertinoSwitchButton({super.key, required this.forIos, this.onChanged});

  @override
  State<CupertinoSwitchButton> createState() => _CupertinoSwitchButtonState();
}

class _CupertinoSwitchButtonState extends State<CupertinoSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      // overrides the default green color of the track
      activeColor: AppColors.kTextBrandPrimary,
      // color of the round icon, which moves from right to left
      thumbColor: AppColors.kWhite,
      // when the switch is off
      trackColor: AppColors.kWhite,
      // boolean variable value
      value: widget.forIos,
      // changes the state of the switch
      onChanged: widget.onChanged ??
          (value) => setState(() {
                widget.forIos = value;
              }),
    );
  }
}
