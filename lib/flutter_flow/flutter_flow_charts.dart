import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as fl;

class FFPieChartData {
  const FFPieChartData({
    required this.values,
    required this.colors,
    required this.radius,
  });

  final List<double> values;
  final List<Color> colors;
  final List<double> radius;
}

class FlutterFlowPieChart extends StatelessWidget {
  const FlutterFlowPieChart({
    super.key,
    required this.data,
    this.donutHoleRadius = 0,
    this.donutHoleColor = Colors.transparent,
    this.sectionLabelStyle,
    this.sectionsSpace = 0,
    this.startDegreeOffset = 0,
    this.labelPositionOffset = 0.5,
  });

  final FFPieChartData data;
  final double donutHoleRadius;
  final Color donutHoleColor;
  final TextStyle? sectionLabelStyle;
  final double sectionsSpace;
  final double startDegreeOffset;
  final double labelPositionOffset;

  @override
  Widget build(BuildContext context) {
    return fl.PieChart(
      fl.PieChartData(
        sections: List.generate(data.values.length, (i) {
          return fl.PieChartSectionData(
            value: data.values[i],
            color: data.colors[i % data.colors.length],
            radius: data.radius[0],
            title: '${data.values[i]}',
            titleStyle: sectionLabelStyle,
          );
        }),
        centerSpaceRadius: donutHoleRadius,
        sectionsSpace: sectionsSpace,
        startDegreeOffset: startDegreeOffset,
      ),
    );
  }
}
