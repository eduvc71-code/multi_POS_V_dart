import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'business_type_card_model.dart';
export 'business_type_card_model.dart';

class BusinessTypeCardWidget extends StatefulWidget {
  const BusinessTypeCardWidget({
    super.key,
    Color? color,
    this.icon,
    String? title,
    bool? selected,
    this.onTap,
  })  : color = color ?? const Color(0x00000000),
        title = title ?? 'Tienda',
        selected = selected ?? true;

  final Color color;
  final Widget? icon;
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  @override
  State<BusinessTypeCardWidget> createState() => _BusinessTypeCardWidgetState();
}

class _BusinessTypeCardWidgetState extends State<BusinessTypeCardWidget> {
  late BusinessTypeCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessTypeCardModel());
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
      onTap: widget.onTap != null ? () => widget.onTap!() : null,
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(24),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: valueOrDefault<Color>(
              valueOrDefault<bool>(
                widget.selected,
                true,
              )
                  ? FlutterFlowTheme.of(context).primary
                  : FlutterFlowTheme.of(context).alternate,
              FlutterFlowTheme.of(context).primary,
            ),
            width: valueOrDefault<double>(
              valueOrDefault<bool>(
                widget.selected,
                true,
              )
                  ? 2.0
                  : 2.0,
              2.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget.color,
                      FlutterFlowTheme.of(context).primary,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: widget.icon!,
                ),
                Text(
                  valueOrDefault<String>(
                    widget.title,
                    'Tienda',
                  ),
                  style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                        fontFamily: "Space Grotesk",
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        height: 1.3,
                      ),
                ),
              ].divide(const SizedBox(height: 8)),
            ),
          ),
        ),
      ),
    );
  }
}
