import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'cash_stat_model.dart';
export 'cash_stat_model.dart';

class CashStatWidget extends StatefulWidget {
  const CashStatWidget({
    super.key,
    Color? color,
    this.icon,
    String? label,
    String? value,
  })  : color = color ?? const Color(0x00000000),
        label = label ?? 'Monto Inicial',
        value = value ?? 'Bs. 500,00';

  final Color color;
  final Widget? icon;
  final String label;
  final String value;

  @override
  State<CashStatWidget> createState() => _CashStatWidgetState();
}

class _CashStatWidgetState extends State<CashStatWidget> {
  late CashStatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CashStatModel());
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
                widget.icon ?? const SizedBox.shrink(),
                Flexible(
                  flex: 1,
                  child: Text(
                    valueOrDefault<String>(
                      widget.label,
                      'Monto Inicial',
                    ),
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                          fontFamily: "Space Grotesk",
                          color: FlutterFlowTheme.of(context).secondaryText,
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
                'Bs. 500,00',
              ),
              style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                    fontFamily: "Urbanist",
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    height: 1.4,
                  ),
            ),
          ].divide(const SizedBox(height: 8)),
        ),
      ),
    );
  }
}