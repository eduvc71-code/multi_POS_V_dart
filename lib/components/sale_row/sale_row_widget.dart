import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'sale_row_model.dart';
export 'sale_row_model.dart';

class SaleRowWidget extends StatefulWidget {
  const SaleRowWidget({
    super.key,
    String? folio,
    String? method,
    Color? statusColor,
    String? time,
    String? total,
    String? status,
  })  : folio = folio ?? 'V-000482',
        method = method ?? 'Efectivo',
        statusColor = statusColor ?? const Color(0x00000000),
        time = time ?? '14:20',
        total = total ?? '348,50',
        status = status ?? 'completada';

  final String folio;
  final String method;
  final Color statusColor;
  final String time;
  final String total;
  final String status;

  @override
  State<SaleRowWidget> createState() => _SaleRowWidgetState();
}

class _SaleRowWidgetState extends State<SaleRowWidget> {
  late SaleRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SaleRowModel());
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget.statusColor,
                  FlutterFlowTheme.of(context).success,
                ),
                borderRadius: BorderRadius.circular(24),
                shape: BoxShape.rectangle,
              ),
              child: Stack(
                alignment: const AlignmentDirectional(0, 0),
                children: [
                  Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Folio: ${widget.folio}',
                        style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                              fontFamily: "Urbanist",
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                      ),
                      Text(
                        'Bs. ${widget.total}',
                        style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                              fontFamily: "Urbanist",
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.time,
                            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  fontFamily: "Poppins",
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                  height: 1.4,
                                ),
                          ),
                          Text(
                            '•',
                            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  fontFamily: "Poppins",
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                  height: 1.4,
                                ),
                          ),
                          Text(
                            widget.method,
                            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                  fontFamily: "Poppins",
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                  height: 1.4,
                                ),
                          ),
                        ].divide(const SizedBox(width: 4)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            widget.statusColor,
                            FlutterFlowTheme.of(context).success,
                          ),
                          borderRadius: BorderRadius.circular(9999),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                          child: Text(
                            widget.status,
                            style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                                  fontFamily: "Space Grotesk",
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ].divide(const SizedBox(height: 4)),
              ),
            ),
          ].divide(const SizedBox(width: 16)),
        ),
      ),
    );
  }
}