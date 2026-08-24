import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'quick_action_model.dart';
export 'quick_action_model.dart';

class QuickActionWidget extends StatefulWidget {
  const QuickActionWidget({
    super.key,
    this.icon,
    String? label,
    String? target,
    Color? tone,
  })  : this.label = label ?? 'Vender',
        this.target = target ?? 'PuntoDeVenta',
        this.tone = tone ?? const Color(0x00000000);

  final Widget? icon;
  final String label;
  final String target;
  final Color tone;

  @override
  State<QuickActionWidget> createState() => _QuickActionWidgetState();
}

class _QuickActionWidgetState extends State<QuickActionWidget> {
  late QuickActionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuickActionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        BuildContextExtensions(context).pushNamed(widget.target);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: valueOrDefault<Color>(
                widget.tone,
                FlutterFlowTheme.of(context).primary,
              ),
              borderRadius: BorderRadius.circular(16),
              shape: BoxShape.rectangle,
            ),
            alignment: AlignmentDirectional(0, 0),
            child: widget.icon,
          ),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                  fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                                  fontWeight: FontWeight.w600,
                                  ,
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  
                  height: 1.2,
                ),
          ),
        ].divide(SizedBox(height: 8)),
      ),
    );
  }
}