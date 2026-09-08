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

class FFLineChartData {
  const FFLineChartData({
    required this.xData,
    required this.yData,
    required this.settings,
  });

  final List<double> xData;
  final List<double> yData;
  final fl.LineChartBarData settings;
}

class ChartStylingInfo {
  const ChartStylingInfo({
    this.backgroundColor = Colors.transparent,
    this.showBorder = false,
  });

  final Color backgroundColor;
  final bool showBorder;
}

class AxisBounds {
  const AxisBounds({
    this.minX,
    this.minY,
    this.maxX,
    this.maxY,
  });

  final double? minX;
  final double? minY;
  final double? maxX;
  final double? maxY;
}

class AxisLabelInfo {
  const AxisLabelInfo({
    this.showLabels = false,
    this.labelTextStyle,
    this.reservedSize,
  });

  final bool showLabels;
  final TextStyle? labelTextStyle;
  final double? reservedSize;
}

class FlutterFlowLineChart extends StatelessWidget {
  const FlutterFlowLineChart({
    super.key,
    required this.data,
    required this.chartStylingInfo,
    this.axisBounds = const AxisBounds(),
    this.xLabels = const [],
    this.xAxisLabelInfo,
    this.yAxisLabelInfo,
  });

  final List<FFLineChartData> data;
  final ChartStylingInfo chartStylingInfo;
  final AxisBounds axisBounds;
  final List<String> xLabels;
  final AxisLabelInfo? xAxisLabelInfo;
  final AxisLabelInfo? yAxisLabelInfo;

  @override
  Widget build(BuildContext context) {
    return fl.LineChart(
      fl.LineChartData(
        lineBarsData: data.map((d) => d.settings.copyWith(
          spots: List.generate(d.xData.length, (i) => fl.FlSpot(d.xData[i], d.yData[i])),
        )).toList(),
        backgroundColor: chartStylingInfo.backgroundColor,
        borderData: fl.FlBorderData(show: chartStylingInfo.showBorder),
        minX: axisBounds.minX,
        maxX: axisBounds.maxX,
        minY: axisBounds.minY,
        maxY: axisBounds.maxY,
        titlesData: fl.FlTitlesData(
          show: true,
          bottomTitles: fl.AxisTitles(
            sideTitles: fl.SideTitles(
              showTitles: xAxisLabelInfo?.showLabels ?? false,
              reservedSize: xAxisLabelInfo?.reservedSize ?? 22,
              getTitlesWidget: (value, meta) {
                if (xLabels.isEmpty || value.toInt() >= xLabels.length || value.toInt() < 0) {
                  return const SizedBox();
                }
                return Text(xLabels[value.toInt()], style: xAxisLabelInfo?.labelTextStyle);
              },
            ),
          ),
          leftTitles: fl.AxisTitles(
            sideTitles: fl.SideTitles(
              showTitles: yAxisLabelInfo?.showLabels ?? false,
              reservedSize: yAxisLabelInfo?.reservedSize ?? 40,
            ),
          ),
          rightTitles: const fl.AxisTitles(sideTitles: fl.SideTitles(showTitles: false)),
          topTitles: const fl.AxisTitles(sideTitles: fl.SideTitles(showTitles: false)),
        ),
      ),
    );
  }
}
