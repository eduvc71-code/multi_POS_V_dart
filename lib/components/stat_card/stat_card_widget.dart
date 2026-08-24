import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'stat_card_model.dart';
export 'stat_card_model.dart';

class StatCardWidget extends StatefulWidget {
  const StatCardWidget({
    super.key,
    this.icon,
    String? label,
    Color? tone,
    String? value,
    bool? isUp,
    String? trend,
  })  : this.label = label ?? 'Créditos Hoy',
        this.tone = tone ?? const Color(0xFFFF9100),
        this.value = value ?? 'Bs. 1.200',
        this.isUp = isUp ?? true,
        this.trend = trend ?? '+12%';

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
            offset: Offset(
              0,
              4,
            ),
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(24),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Container(
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
                    widget!.tone,
                    Color(0xFFFF9100),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  shape: BoxShape.rectangle,
                ),
                child: widget!.icon!,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.label,
                      'Créditos Hoy',
                    ),
                    style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                          font: GoogleFonts.spaceGrotesk(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          height: 1.3,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget!.value,
                      'Bs. 1.200',
                    ),
                    style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                          font: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w800,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w800,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                          height: 1.3,
                        ),
                  ),
                ].divide(SizedBox(height: 4)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    child: Stack(
                      alignment: AlignmentDirectional(0, 0),
                      children: [
                        Icon(
                          Icons.trending_up_rounded,
                          color: valueOrDefault<Color>(
                            valueOrDefault<bool>(
                              widget!.isUp,
                              true,
                            )
                                ? FlutterFlowTheme.of(context).success
                                : FlutterFlowTheme.of(context).error,
                            FlutterFlowTheme.of(context).success,
                          ),
                          size: 14,
                        ),
                        Icon(
                          Icons.trending_down_rounded,
                          color: valueOrDefault<Color>(
                            valueOrDefault<bool>(
                              widget!.isUp,
                              true,
                            )
                                ? FlutterFlowTheme.of(context).success
                                : FlutterFlowTheme.of(context).error,
                            FlutterFlowTheme.of(context).success,
                          ),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget!.trend,
                      '+12%',
                    ),
                    style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                          font: GoogleFonts.spaceGrotesk(
                            fontWeight: FontWeight.w600,
                          ),
                          color: valueOrDefault<Color>(
                            valueOrDefault<bool>(
                              widget!.isUp,
                              true,
                            )
                                ? FlutterFlowTheme.of(context).success
                                : FlutterFlowTheme.of(context).error,
                            FlutterFlowTheme.of(context).success,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelSmall.fontStyle,
                          height: 1.2,
                        ),
                  ),
                ].divide(SizedBox(width: 4)),
              ),
            ].divide(SizedBox(height: 8)),
          ),
        ),
      ),
    );
  }
}
