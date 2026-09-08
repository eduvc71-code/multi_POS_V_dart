import 'package:flutter/material.dart';

export 'package:go_router/go_router.dart';

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

String formatBs(double amount) {
  final parts = amount.toStringAsFixed(2).split('.');
  final integerPart = parts[0];
  final decimalPart = parts[1];

  final buffer = StringBuffer();
  int count = 0;
  final isNegative = integerPart.startsWith('-');
  final digits = isNegative ? integerPart.substring(1) : integerPart;

  for (int i = digits.length - 1; i >= 0; i--) {
    if (count > 0 && count % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
    count++;
  }

  final formattedInteger = buffer.toString().split('').reversed.join('');
  final sign = isNegative ? '-' : '';

  return 'Bs. $sign$formattedInteger,$decimalPart';
}

void safeSetState(VoidCallback callback) {
  callback();
}

abstract class FlutterFlowModel<W extends StatefulWidget> {
  void initState(BuildContext context);
  void dispose();
  void onUpdate() {}
  void maybeDispose() => dispose();
}

T createModel<T extends FlutterFlowModel>(
  BuildContext context,
  T Function() defaultBuilder,
) {
  final model = defaultBuilder();
  model.initState(context);
  return model;
}

extension WidgetListDivideExtension on List<Widget> {
  List<Widget> divide(Widget separator) {
    if (isEmpty) return this;
    return [
      for (var i = 0; i < length; i++) ...[if (i > 0) separator, this[i]],
    ];
  }
}

extension BuildContextExtensions on BuildContext {}

Widget wrapWithModel<T extends FlutterFlowModel>({
  required T model,
  required VoidCallback updateCallback,
  required Widget child,
}) {
  return child;
}
