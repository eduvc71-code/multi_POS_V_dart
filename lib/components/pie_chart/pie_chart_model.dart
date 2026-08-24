import 'package:multi_p_o_s/components/chart_legend/chart_legend_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_charts.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'pie_chart_widget.dart' show PieChartWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PieChartModel extends FlutterFlowModel<PieChartWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ChartLegend.
  late ChartLegendModel chartLegendModel1;
  // Model for ChartLegend.
  late ChartLegendModel chartLegendModel2;

  @override
  void initState(BuildContext context) {
    chartLegendModel1 = createModel(context, () => ChartLegendModel());
    chartLegendModel2 = createModel(context, () => ChartLegendModel());
  }

  @override
  void dispose() {
    chartLegendModel1.dispose();
    chartLegendModel2.dispose();
  }
}