import 'package:multi_p_o_s/components/nav_item/nav_item_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_child_model.dart';
export 'bottom_nav_child_model.dart';

class BottomNavChildWidget extends StatefulWidget {
  const BottomNavChildWidget({super.key});

  @override
  State<BottomNavChildWidget> createState() => _BottomNavChildWidgetState();
}

class _BottomNavChildWidgetState extends State<BottomNavChildWidget> {
  late BottomNavChildModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavChildModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: wrapWithModel(
            model: _model.navItemModel1,
            updateCallback: () => safeSetState(() {}),
            child: NavItemWidget(
              label: 'Inicio',
              icon: Icon(
                Icons.grid_view_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24,
              ),
              target: 'PanelPrincipal',
              selected: true,
            ),
          ),
        ),
        Expanded(
          child: wrapWithModel(
            model: _model.navItemModel2,
            updateCallback: () => safeSetState(() {}),
            child: NavItemWidget(
              label: 'Vender',
              icon: Icon(
                Icons.shopping_cart_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24,
              ),
              target: 'PuntoDeVenta',
              selected: false,
            ),
          ),
        ),
        Expanded(
          child: wrapWithModel(
            model: _model.navItemModel3,
            updateCallback: () => safeSetState(() {}),
            child: NavItemWidget(
              label: 'Historial',
              icon: Icon(
                Icons.history_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24,
              ),
              target: 'HistorialDeVentas',
              selected: false,
            ),
          ),
        ),
        Expanded(
          child: wrapWithModel(
            model: _model.navItemModel4,
            updateCallback: () => safeSetState(() {}),
            child: NavItemWidget(
              label: 'Reportes',
              icon: Icon(
                Icons.insights_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24,
              ),
              target: 'ReportesYMetricas',
              selected: false,
            ),
          ),
        ),
        Expanded(
          child: wrapWithModel(
            model: _model.navItemModel5,
            updateCallback: () => safeSetState(() {}),
            child: NavItemWidget(
              label: 'Ajustes',
              icon: Icon(
                Icons.settings_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24,
              ),
              target: 'ConfiguracionYEmpresas',
              selected: false,
            ),
          ),
        ),
      ],
    );
  }
}
