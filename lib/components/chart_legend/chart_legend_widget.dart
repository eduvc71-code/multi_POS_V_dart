import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'chart_legend_model.dart';
export 'chart_legend_model.dart';

class ChartLegendWidget extends StatefulWidget {
  const ChartLegendWidget({
    super.key,
    String? data,
    String? labels,
    String? colors,
    double? markerSize,
    double? spacing,
    double? runSpacing,
    Color? labelColor,
    Color? valueColor,
    String? textStyle,
    String? valueStyle,
    double? labelMaxWidth,
    String? direction,
    String? valueMode,
  })  : data = data ?? 'SlotValue($data)',
        labels = labels ?? 'SlotValue($labels)',
        colors = colors ?? 'SlotValue($colors)',
        markerSize = markerSize ?? 8.0,
        spacing = spacing ?? 6.0,
        runSpacing = runSpacing ?? 8.0,
        labelColor = labelColor ?? const Color(0x00000000),
        valueColor = valueColor ?? const Color(0x00000000),
        textStyle = textStyle ?? 'label_small',
        valueStyle = valueStyle ?? 'label_small',
        labelMaxWidth = labelMaxWidth ?? 0.0,
        direction = direction ?? 'vertical',
        valueMode = valueMode ?? 'percent';

  final String data;
  final String labels;
  final String colors;
  final double markerSize;
  final double spacing;
  final double runSpacing;
  final Color labelColor;
  final Color valueColor;
  final String textStyle;
  final String valueStyle;
  final double labelMaxWidth;
  final String direction;
  final String valueMode;

  @override
  State<ChartLegendWidget> createState() => _ChartLegendWidgetState();
}

class _ChartLegendWidgetState extends State<ChartLegendWidget> {
  late ChartLegendModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChartLegendModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 1,
      height: 1,
    );
  }
}
