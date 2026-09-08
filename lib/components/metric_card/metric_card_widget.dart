import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'metric_card_model.dart';
export 'metric_card_model.dart';

@Preview()
Widget previewMetricCard() {
  return const MetricCardWidget(
    label: 'Ventas Totales',
    value: 'Bs. 42.850',
    delta: '+12.5%',
    isUp: true,
    icon: Icon(Icons.trending_up_rounded, color: Colors.white, size: 20),
    tone: Color(0xFF0066FF),
  );
}

class MetricCardWidget extends StatefulWidget {
  const MetricCardWidget({
    super.key,
    String? delta,
    this.icon,
    String? label,
    Color? tone,
    String? value,
    bool? isUp,
  })  : delta = delta ?? '+12.5%',
        label = label ?? 'Ventas Totales',
        tone = tone ?? const Color(0x00000000),
        value = value ?? 'Bs. 42.850',
        isUp = isUp ?? true;

  final String delta;
  final Widget? icon;
  final String label;
  final Color tone;
  final String value;
  final bool isUp;

  @override
  State<MetricCardWidget> createState() => _MetricCardWidgetState();
}

class _MetricCardWidgetState extends State<MetricCardWidget> {
  late MetricCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MetricCardModel());
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget.tone,
                      FlutterFlowTheme.of(context).primary,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: widget.icon!,
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
                      valueOrDefault<String>(
                        widget.delta,
                        '+12.5%',
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                            fontFamily: "Space Grotesk",
                            color: widget.isUp
                                ? FlutterFlowTheme.of(context).success
                                : FlutterFlowTheme.of(context).error,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                    ),
                  ].divide(const SizedBox(width: 4)),
                ),
              ],
            ),
            Text(
              valueOrDefault<String>(
                widget.label,
                'Ventas Totales',
              ),
              style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                    fontFamily: "Space Grotesk",
                    color: Colors.black,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelSmall.fontStyle,
                    height: 1.2,
                  ),
            ),
            Text(
              valueOrDefault<String>(
                widget.value,
                'Bs. 42.850',
              ),
              style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                    fontFamily: "Urbanist",
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w800,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    height: 1.3,
                  ),
            ),
          ].divide(const SizedBox(height: 4)),
        ),
      ),
    );
  }
}