import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'package:sloopify_mobile/core/utils/helper/toast_utils.dart';

class Utils {
  static void copyToClipboard(String text,) {
    Clipboard.setData(ClipboardData(text: text));
   ToastUtils.showSusToastMessage("post copied to clipboard");
  }
}
