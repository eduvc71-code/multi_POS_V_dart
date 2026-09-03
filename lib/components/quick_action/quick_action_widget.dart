import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'quick_action_model.dart';
export 'quick_action_model.dart';

@Preview()
Widget previewQuickAction() {
  return const QuickActionWidget(
    icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.white, size: 28),
    label: 'Vender',
    tone: Color(0xFF0066FF),
  );
}

class QuickActionWidget extends StatefulWidget {
  const QuickActionWidget({
    super.key,
    this.icon,
    String? label,
    String? target,
    Color? tone,
  })  : label = label ?? 'Vender',
        target = target ?? 'PuntoDeVenta',
        tone = tone ?? const Color(0x00000000);

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
            alignment: const AlignmentDirectional(0, 0),
            child: widget.icon,
          ),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                  fontFamily: "Space Grotesk",
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
          ),
        ].divide(const SizedBox(height: 8)),
      ),
    );
  }
}