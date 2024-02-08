import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: avoid_classes_with_only_static_members
class InputHelper {
  static MaskTextInputFormatter maskTextInputFormatter() {
    return MaskTextInputFormatter(
      mask: "+7(###) ###-##-##",
      filter: {
        "#": RegExp('[0-9]'),
      },
    );
  }

  static MaskTextInputFormatter iinTextInputFormatter() {
    return MaskTextInputFormatter(
      mask: "###-###-###-###",
      filter: {
        "#": RegExp('[0-9]'),
      },
    );
  }

  static MaskTextInputFormatter bankCardFormatter() {
    return MaskTextInputFormatter(
      mask: "#### #### #### ####",
      filter: {
        "#": RegExp('[0-9]'),
      },
    );
  }
}
