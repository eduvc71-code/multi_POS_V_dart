import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'credit_stat_model.dart';
export 'credit_stat_model.dart';

@Preview()
Widget previewCreditStat() {
  return const CreditStatWidget(
    label: 'Por Cobrar',
    value: 'Bs. 12.450,00',
    icon: Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF0066FF), size: 24),
  );
}

class CreditStatWidget extends StatefulWidget {
  const CreditStatWidget({
    super.key,
    this.icon,
    String? label,
    Color? tone,
    String? value,
  })  : label = label ?? 'Por Cobrar',
        tone = tone ?? const Color(0x00000000),
        value = value ?? 'Bs. 12.450,00';

  final Widget? icon;
  final String label;
  final Color tone;
  final String value;

  @override
  State<CreditStatWidget> createState() => _CreditStatWidgetState();
}

class _CreditStatWidgetState extends State<CreditStatWidget> {
  late CreditStatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreditStatModel());
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
                Text(
                  valueOrDefault<String>(
                    widget.label,
                    'Por Cobrar',
                  ),
                  style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                        fontFamily: "Space Grotesk",
                        color: Colors.black,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        height: 1.2,
                      ),
                ),
              ],
            ),
            Text(
              valueOrDefault<String>(
                widget.value,
                'Bs. 12.450,00',
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