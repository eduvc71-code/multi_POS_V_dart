import 'package:multi_p_o_s/components/chart_legend/chart_legend_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_charts.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'pie_chart_model.dart';
export 'pie_chart_model.dart';

@Preview()
Widget previewPieChart() {
  return const PieChartWidget(
    centerValue: 'Bs. 4.850',
    centerLabel: 'Total Hoy',
    data: '50,25,15,10',
    labels: 'Efectivo,Tarjeta,Transferencia,Crédito',
  );
}

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    String? centerValue,
    bool? centerValuePresent,
    String? centerLabel,
    bool? centerLabelPresent,
    String? data,
    String? labels,
    String? colors,
    bool? animate,
    double? startAngle,
    String? variant,
    String? size,
    String? legend,
    String? legendValue,
    String? ring,
    String? gap,
  })  : centerValue = centerValue ?? '',
        centerValuePresent = centerValuePresent ?? false,
        centerLabel = centerLabel ?? '',
        centerLabelPresent = centerLabelPresent ?? false,
        data = data ?? '45,25,15,10,5',
        labels = labels ?? 'Ferretería,Autopartes,Tienda,Farmacia,Otros',
        colors = colors ?? '#0066FF,#FF2D87,#FFE500,#00C853,#9C27B0',
        animate = animate ?? false,
        startAngle = startAngle ?? -90.0,
        variant = variant ?? 'donut',
        size = size ?? 'medium',
        legend = legend ?? 'right',
        legendValue = legendValue ?? 'percent',
        ring = ring ?? 'thick',
        gap = gap ?? 'normal';

  final String centerValue;
  final bool centerValuePresent;
  final String centerLabel;
  final bool centerLabelPresent;
  final String data;
  final String labels;
  final String colors;
  final bool animate;
  final double startAngle;
  final String variant;
  final String size;
  final String legend;
  final String legendValue;
  final String ring;
  final String gap;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  late PieChartModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PieChartModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pieChartPieChartColorsList1 = [
      FlutterFlowTheme.of(context).primary,
      FlutterFlowTheme.of(context).secondary,
      FlutterFlowTheme.of(context).tertiary
    ];
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: const AlignmentDirectional(0, 0),
                children: [
                  SizedBox(
                    width: valueOrDefault<double>(
                      () {
                        if (valueOrDefault<String>(widget.size, 'medium') == 'compact') {
                          return 120.0;
                        } else if (valueOrDefault<String>(widget.size, 'medium') == 'large') {
                          return 200.0;
                        } else if (valueOrDefault<String>(widget.size, 'medium') == 'expanded') {
                          return double.infinity;
                        } else {
                          return 156.0;
                        }
                      }(),
                      156.0,
                    ),
                    height: valueOrDefault<double>(
                      () {
                        if (valueOrDefault<String>(widget.size, 'medium') == 'compact') {
                          return 120.0;
                        } else if (valueOrDefault<String>(widget.size, 'medium') == 'large') {
                          return 200.0;
                        } else if (valueOrDefault<String>(widget.size, 'medium') == 'expanded') {
                          return double.infinity;
                        } else {
                          return 156.0;
                        }
                      }(),
                      156.0,
                    ),
                    child: FlutterFlowPieChart(
                      data: FFPieChartData(
                        values: widget.data
                            .split(',')
                            .map((value) => double.tryParse(value.trim()) ?? 0.0)
                            .toList(),
                        colors: pieChartPieChartColorsList1,
                        radius: [50.0],
                      ),
                      donutHoleRadius: valueOrDefault<String>(widget.variant, 'donut') == 'donut' ? 30.0 : 0.0,
                      donutHoleColor: Colors.transparent,
                      sectionLabelStyle: FlutterFlowTheme.of(context).labelSmall.copyWith(
                            fontFamily: "Space Grotesk",
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                      sectionsSpace: valueOrDefault<double>(
                        () {
                          if (valueOrDefault<String>(widget.gap, 'normal') == 'none') {
                            return 0.0;
                          } else if (valueOrDefault<String>(widget.gap, 'normal') == 'tight') {
                            return 2.0;
                          } else if (valueOrDefault<String>(widget.gap, 'normal') == 'wide') {
                            return 8.0;
                          } else {
                            return 4.0;
                          }
                        }(),
                        4.0,
                      ),
                      startDegreeOffset: valueOrDefault<double>(widget.startAngle, -90.0),
                      labelPositionOffset: 0.6,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.centerValue,
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                              fontFamily: "Urbanist",
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                              height: 1.4,
                            ),
                      ),
                      Text(
                        widget.centerLabel,
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                              fontFamily: "Space Grotesk",
                              color: Colors.black,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                              height: 1.2,
                            ),
                      ),
                    ].divide(const SizedBox(height: 0)),
                  ),
                ],
              ),
              wrapWithModel(
                model: _model.chartLegendModel1,
                updateCallback: () => safeSetState(() {}),
                child: ChartLegendWidget(
                  data: valueOrDefault<String>(widget.data, '45,25,15,10,5'),
                  labels: valueOrDefault<String>(widget.labels, 'Ferretería,Autopartes,Tienda,Farmacia,Otros'),
                  colors: valueOrDefault<String>(widget.colors, '#0066FF,#FF2D87,#FFE500,#00C853,#9C27B0'),
                  markerSize: 8.0,
                  spacing: 6.0,
                  runSpacing: 8.0,
                  labelColor: FlutterFlowTheme.of(context).primaryText,
                  valueColor: Colors.black,
                  textStyle: 'label_small',
                  valueStyle: 'label_small',
                  labelMaxWidth: 0.0,
                  direction: 'vertical',
                  valueMode: 'percent',
                ),
              ),
            ],
          ),
        ),
        wrapWithModel(
          model: _model.chartLegendModel2,
          updateCallback: () => safeSetState(() {}),
          child: ChartLegendWidget(
            data: valueOrDefault<String>(widget.data, '45,25,15,10,5'),
            labels: valueOrDefault<String>(widget.labels, 'Ferretería,Autopartes,Tienda,Farmacia,Otros'),
            colors: valueOrDefault<String>(widget.colors, '#0066FF,#FF2D87,#FFE500,#00C853,#9C27B0'),
            markerSize: 8.0,
            spacing: 6.0,
            runSpacing: 8.0,
            labelColor: FlutterFlowTheme.of(context).primaryText,
            valueColor: Colors.black,
            textStyle: 'label_small',
            valueStyle: 'label_small',
            labelMaxWidth: 0.0,
            direction: 'horizontal',
            valueMode: 'percent',
          ),
        ),
      ].divide(const SizedBox(height: 12)),
    );
  }
}