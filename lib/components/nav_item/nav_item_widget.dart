import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'nav_item_model.dart';
export 'nav_item_model.dart';

@Preview()
Widget previewNavItemHome() {
  return const NavItemWidget(
    label: 'Inicio',
    icon: Icon(Icons.home_rounded, color: Color(0xFF0066FF), size: 24),
    selected: true,
  );
}

@Preview()
Widget previewNavItemSettings() {
  return const NavItemWidget(
    label: 'Ajustes',
    icon: Icon(Icons.settings_rounded, color: Color(0xFF57636C), size: 24),
    selected: false,
  );
}

class NavItemWidget extends StatefulWidget {
  const NavItemWidget({
    super.key,
    String? label,
    this.icon,
    String? target,
    bool? selected,
  })  : label = label ?? 'Inicio',
        target = target ?? 'PanelPrincipal',
        selected = selected ?? true;

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
      padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      child: InkWell(
        onTap: () async {
          if (widget.target.isNotEmpty) {
            final prefs = await SharedPreferences.getInstance();
            final role = prefs.getString('user_role') ?? 'admin';
            final restricted = ['ConfiguracionYEmpresas', 'ReportesYMetricas'];

            if (role != 'admin' && restricted.contains(widget.target)) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Acceso Restringido: Requiere rol de Propietario'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
              return;
            }

            if (context.mounted) {
              context.goNamed(widget.target);
            }
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) widget.icon!,
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                valueOrDefault<String>(widget.label, 'Inicio'),
                maxLines: 1,
                softWrap: false,
                style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                    fontFamily: "Poppins",
                    color: widget.selected
                        ? FlutterFlowTheme.of(context).primary
                        : Colors.black,
                    letterSpacing: 0.0,
                    fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                    height: 1.5,
                  ),
              ),
            ),
          ].divide(const SizedBox(height: 2)),
        ),
      ),
    );
  }
}
