import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'nav_item_model.dart';
export 'nav_item_model.dart';

class NavItemWidget extends StatefulWidget {
  const NavItemWidget({
    super.key,
    String? label,
    this.icon,
    String? target,
    bool? selected,
  })  : this.label = label ?? 'Inicio',
        this.target = target ?? 'PanelPrincipal',
        this.selected = selected ?? true;

  final String label;
  final Widget? icon;
  final String target;
  final bool selected;

  @override
  State<NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<NavItemWidget> {
  late NavItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget!.icon!,
          Text(
            valueOrDefault<String>(
              widget!.label,
              'Inicio',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: FlutterFlowTheme.of(context).bodyMedium.fontSize,
                  color: valueOrDefault<Color>(
                    valueOrDefault<bool>(
                      widget!.selected,
                      true,
                    )
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).secondaryText,
                    FlutterFlowTheme.of(context).primary,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  
                  height: 1.5,
                ),
          ),
        ].divide(SizedBox(height: 2)),
      ),
    );
  }
}
