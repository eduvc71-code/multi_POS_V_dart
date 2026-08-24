import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  })  : this.folio = folio ?? 'V-000482',
        this.method = method ?? 'Efectivo',
        this.statusColor = statusColor ?? const Color(0x00000000),
        this.time = time ?? '14:20',
        this.total = total ?? '348,50',
        this.status = status ?? 'completada';

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
        padding: EdgeInsets.all(16),
        child: Container(
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
                    widget!.statusColor,
                    FlutterFlowTheme.of(context).success,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  shape: BoxShape.rectangle,
                ),
                child: Container(
                  width: 24,
                  height: 24,
                  child: Stack(
                    alignment: AlignmentDirectional(0, 0),
                    children: [
                      Icon(
                        Icons.close_rounded,
                        color: valueOrDefault<Color>(
                          widget!.statusColor,
                          FlutterFlowTheme.of(context).success,
                        ),
                        size: 24,
                      ),
                      Icon(
                        Icons.shopping_bag_rounded,
                        color: valueOrDefault<Color>(
                          widget!.statusColor,
                          FlutterFlowTheme.of(context).success,
                        ),
                        size: 24,
                      ),
                    ],
                  ),
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
                          valueOrDefault<String>(
                            'Folio: ${widget!.folio}',
                            'Folio: V-000482',
                          ),
                          style:
                              FlutterFlowTheme.of(context).titleSmall.copyWith(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            'Bs. ${widget!.total}',
                            'Bs. 348,50',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .copyWith(
                                font: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold,
                                ),
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
                              valueOrDefault<String>(
                                widget!.time,
                                '14:20',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .copyWith(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    height: 1.4,
                                  ),
                            ),
                            Text(
                              '•',
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .copyWith(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    height: 1.4,
                                  ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                widget!.method,
                                'Efectivo',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .copyWith(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    height: 1.4,
                                  ),
                            ),
                          ].divide(SizedBox(width: 4)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: valueOrDefault<Color>(
                              widget!.statusColor,
                              FlutterFlowTheme.of(context).success,
                            ),
                            borderRadius: BorderRadius.circular(9999),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                            child: Container(
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.status,
                                  'completada',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .copyWith(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      color: valueOrDefault<Color>(
                                        widget!.statusColor,
                                        FlutterFlowTheme.of(context).success,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(height: 4)),
                ),
              ),
            ].divide(SizedBox(width: 16)),
          ),
        ),
      ),
    );
  }
}
