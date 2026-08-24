import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'inventory_stat_model.dart';
export 'inventory_stat_model.dart';

class InventoryStatWidget extends StatefulWidget {
  const InventoryStatWidget({
    super.key,
    Color? color,
    this.icon,
    String? label,
    String? value,
  })  : color = color ?? const Color(0x00000000),
        label = label ?? 'Total Items',
        value = value ?? '1,284';

  final Color color;
  final Widget? icon;
  final String label;
  final String value;

  @override
  State<InventoryStatWidget> createState() => _InventoryStatWidgetState();
}

class _InventoryStatWidgetState extends State<InventoryStatWidget> {
  late InventoryStatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InventoryStatModel());
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
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget.color,
                  FlutterFlowTheme.of(context).primary,
                ),
                borderRadius: BorderRadius.circular(9999),
                shape: BoxShape.rectangle,
              ),
              child: widget.icon ?? const SizedBox.shrink(),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget.label,
                    'Total Items',
                  ),
                  style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                        fontFamily: "Space Grotesk",
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        height: 1.2,
                      ),
                ),
                Text(
                  valueOrDefault<String>(
                    widget.value,
                    '1,284',
                  ),
                  style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                        fontFamily: "Urbanist",
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                ),
              ].divide(const SizedBox(height: 4)),
            ),
          ].divide(const SizedBox(width: 8)),
        ),
      ),
    );
  }
}