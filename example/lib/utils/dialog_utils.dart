import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

abstract class DialogUtils {
  static void toast(String text) {
    SmartDialog.showToast(text,displayType: SmartToastType.onlyRefresh);
  }

  static void loading([String? text]) {
    SmartDialog.showLoading(
      msg: text ?? "loading",
      backDismiss: false,
    );
  }

  static void dismiss() => SmartDialog.dismiss(status: SmartStatus.loading);
}
