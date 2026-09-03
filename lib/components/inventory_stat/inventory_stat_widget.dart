import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'inventory_stat_model.dart';
export 'inventory_stat_model.dart';

@Preview()
Widget previewInventoryStat() {
  return const InventoryStatWidget(
    label: 'Productos en Stock',
    value: '1.284',
    icon: Icon(Icons.inventory_2_rounded, color: Colors.white, size: 20),
    color: Color(0xFF0066FF),
  );
}

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
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget.color,
                  FlutterFlowTheme.of(context).primary,
                ),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: widget.icon ?? const SizedBox.shrink(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.label,
                      'Total Items',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                          fontFamily: "Space Grotesk",
                          color: Colors.black87,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget.value,
                      '0',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                          fontFamily: "Urbanist",
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}