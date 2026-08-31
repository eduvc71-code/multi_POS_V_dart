import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'checkbox_model.dart';
export 'checkbox_model.dart';

@Preview()
Widget previewCheckboxChecked() {
  return const CheckboxWidget(
    label: 'Acepto los términos y condiciones',
    isChecked: true,
  );
}

@Preview()
Widget previewCheckboxUnchecked() {
  return const CheckboxWidget(
    label: 'Suscribirse al boletín',
    isChecked: false,
    hasSubtitle: true,
    subtitle: 'Recibe noticias y ofertas especiales',
  );
}

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({
    super.key,
    String? label,
    String? subtitle,
    Color? color,
    bool? isChecked,
    bool? hasSubtitle,
    bool? disabled,
  })  : label = label ?? 'Acepto los términos y condiciones de MultiPOS',
        subtitle = subtitle ?? 'Receive weekly updates',
        color = color ?? const Color(0x00000000),
        isChecked = isChecked ?? true,
        hasSubtitle = hasSubtitle ?? false,
        disabled = disabled ?? false;

  final String label;
  final String subtitle;
  final Color color;
  final bool isChecked;
  final bool hasSubtitle;
  final bool disabled;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  late CheckboxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckboxModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: valueOrDefault<double>(
        widget.disabled ? 0.55 : 1.0,
        1.0,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: widget.isChecked
                    ? FlutterFlowTheme.of(context).primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: widget.isChecked
                      ? Colors.transparent
                      : FlutterFlowTheme.of(context).alternate,
                  width: 1,
                ),
              ),
              alignment: const AlignmentDirectional(0, 0),
              child: widget.isChecked
                  ? Icon(
                      Icons.check_rounded,
                      color: FlutterFlowTheme.of(context).onPrimary,
                      size: 16,
                    )
                  : null,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.label,
                      'Acepto los términos y condiciones de MultiPOS',
                    ),
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                          fontFamily: "Poppins",
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                          height: 1.5,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.hasSubtitle)
                    Text(
                      valueOrDefault<String>(
                        widget.subtitle,
                        'Receive weekly updates',
                      ),
                      maxLines: 3,
                      style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                            fontFamily: "Poppins",
                            color: Colors.black,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                            height: 1.4,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ].divide(const SizedBox(width: 16)),
        ),
      ),
    );
  }
}