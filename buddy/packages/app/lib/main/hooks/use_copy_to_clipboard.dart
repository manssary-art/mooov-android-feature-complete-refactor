import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import 'flutter_hooks.dart';

void Function(String value) useCopyToClipboard(BuildContext context) {
  final showSnackBar = useShowSnackBar(context);
  return useCallback((String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    showSnackBar(LocaleKeys.CopiedToClipboard.tr());
  }, []);
}
