import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'nav_item_model.dart';
export 'nav_item_model.dart';

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
        onTap: () {
          // Navegar a la página target
          if (widget.target.isNotEmpty) {
            context.pushNamed(widget.target);
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
                        : FlutterFlowTheme.of(context).secondaryText,
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
