import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'stat_card_model.dart';
export 'stat_card_model.dart';

@Preview()
Widget previewStatCard() {
  return const StatCardWidget(
    icon: Icon(Icons.trending_up, color: Colors.white, size: 24),
    label: 'Ventas del Día',
    value: 'Bs. 4.850,00',
    isUp: true,
    trend: '+15%',
    tone: Color(0xFF0066FF),
  );
}

class StatCardWidget extends StatefulWidget {
  const StatCardWidget({
    super.key,
    this.icon,
    String? label,
    Color? tone,
    String? value,
    bool? isUp,
    String? trend,
  })  : label = label ?? 'Creditos Hoy',
        tone = tone ?? const Color(0xFFFF9100),
        value = value ?? 'Bs. 1.200',
        isUp = isUp ?? true,
        trend = trend ?? '+12%';

  final Widget? icon;
  final String label;
  final Color tone;
  final String value;
  final bool isUp;
  final String trend;

  @override
  State<StatCardWidget> createState() => _StatCardWidgetState();
}

class _StatCardWidgetState extends State<StatCardWidget> {
  late StatCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: FlutterFlowTheme.of(context).onAccent4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget.tone,
                  const Color(0xFFFF9100),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                shape: BoxShape.rectangle,
              ),
              child: widget.icon ?? Icon(
                      Icons.bar_chart,
                      color: FlutterFlowTheme.of(context).onPrimary,
                      size: 24,
                    ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                        fontFamily: "Space Grotesk",
                        color: Colors.black,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        height: 1.3,
                      ),
                ),
                Text(
                  widget.value,
                  style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                        fontFamily: "Urbanist",
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w800,
                        fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        height: 1.3,
                      ),
                ),
              ].divide(const SizedBox(height: 4)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 14,
                  height: 14,
                  child: Icon(
                    widget.isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                    color: widget.isUp
                        ? FlutterFlowTheme.of(context).success
                        : FlutterFlowTheme.of(context).error,
                    size: 14,
                  ),
                ),
                Text(
                  widget.trend,
                  style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                        fontFamily: "Space Grotesk",
                        color: widget.isUp
                            ? FlutterFlowTheme.of(context).success
                            : FlutterFlowTheme.of(context).error,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                        height: 1.2,
                      ),
                ),
              ].divide(const SizedBox(width: 4)),
            ),
          ].divide(const SizedBox(height: 8)),
        ),
      ),
    );
  }
}