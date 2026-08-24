import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

export 'package:go_router/go_router.dart';

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

void safeSetState(VoidCallback callback) {
  callback();
}

abstract class FlutterFlowModel<W extends StatefulWidget> {
  bool _isInitialized = false;
  void initState(BuildContext context);
  void dispose();
  void onUpdate() {}
  void maybeDispose() => dispose();
}

T createModel<T extends FlutterFlowModel>(
    BuildContext context, T Function() defaultBuilder) {
  final model = defaultBuilder();
  model.initState(context);
  return model;
}

extension WidgetListDivideExtension on List<Widget> {
  List<Widget> divide(Widget separator) {
    if (isEmpty) return this;
    return [
      for (var i = 0; i < length; i++) ...[
        if (i > 0) separator,
        this[i],
      ],
    ];
  }
}

extension BuildContextExtensions on BuildContext {
  void pushNamed(String name, {Map<String, String> pathParameters = const {}, Map<String, String> queryParameters = const {}}) =>
      GoRouter.of(this).pushNamed(name, pathParameters: pathParameters, queryParameters: queryParameters);

  void goNamed(String name, {Map<String, String> pathParameters = const {}, Map<String, String> queryParameters = const {}}) =>
      GoRouter.of(this).goNamed(name, pathParameters: pathParameters, queryParameters: queryParameters);
}

Widget wrapWithModel<T extends FlutterFlowModel>({
  required T model,
  required VoidCallback updateCallback,
  required Widget child,
}) {
  return child;
}
