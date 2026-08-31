import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'history_stat_model.dart';
export 'history_stat_model.dart';

@Preview()
Widget previewHistoryStat() {
  return const HistoryStatWidget(
    label: 'Ventas de la Semana',
    value: 'Bs. 24.250,00',
    icon: Icon(Icons.history_rounded, color: Color(0xFF24D193), size: 24),
  );
}

class HistoryStatWidget extends StatefulWidget {
  const HistoryStatWidget({
    super.key,
    this.icon,
    String? label,
    Color? tone,
    String? value,
  })  : label = label ?? 'Ventas Hoy',
        tone = tone ?? const Color(0x00000000),
        value = value ?? 'Bs. 4.250,00';

  final Widget? icon;
  final String label;
  final Color tone;
  final String value;

  @override
  State<HistoryStatWidget> createState() => _HistoryStatWidgetState();
}

class _HistoryStatWidgetState extends State<HistoryStatWidget> {
  late HistoryStatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryStatModel());
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
        borderRadius: BorderRadius.circular(24),
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
                if (widget.icon != null) widget.icon!,
                Flexible(
                  child: Text(
                    valueOrDefault<String>(
                      widget.label,
                      'Ventas Hoy',
                    ),
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                          fontFamily: "Space Grotesk",
                          color: Colors.black,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                          height: 1.2,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              valueOrDefault<String>(
                widget.value,
                'Bs. 4.250,00',
              ),
              style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                    fontFamily: "Urbanist",
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    height: 1.3,
                  ),
            ),
          ].divide(const SizedBox(height: 4)),
        ),
      ),
    );
  }
}