import 'package:multi_p_o_s/components/nav_item/nav_item_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_child5_model.dart';
export 'bottom_nav_child5_model.dart';

class BottomNavChild5Widget extends StatefulWidget {
  const BottomNavChild5Widget({super.key});

  @override
  State<BottomNavChild5Widget> createState() => _BottomNavChild5WidgetState();
}

class _BottomNavChild5WidgetState extends State<BottomNavChild5Widget> {
  late BottomNavChild5Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavChild5Model());
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
        wrapWithModel(
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
            selected: false,
          ),
        ),
        wrapWithModel(
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
        wrapWithModel(
          model: _model.navItemModel3,
          updateCallback: () => safeSetState(() {}),
          child: NavItemWidget(
            label: 'Stock',
            icon: Icon(
              Icons.inventory_2_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24,
            ),
            target: 'InventarioDeProductos',
            selected: false,
          ),
        ),
        wrapWithModel(
          model: _model.navItemModel4,
          updateCallback: () => safeSetState(() {}),
          child: NavItemWidget(
            label: 'Ajustes',
            icon: Icon(
              Icons.settings_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24,
            ),
            target: 'ConfiguracionYEmpresas',
            selected: true,
          ),
        ),
      ],
    );
  }
}
