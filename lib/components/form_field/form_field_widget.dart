import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'form_field_model.dart';
export 'form_field_model.dart';

@Preview()
Widget previewFormField() {
  return const FormFieldWidget(
    label: 'Nombre del Negocio',
    hint: 'Mi Tienda Express',
  );
}

class FormFieldWidget extends StatefulWidget {
  const FormFieldWidget({
    super.key,
    this.model,
    String? hint,
    String? icon,
    String? label,
    bool? isPassword,
  })  : hint = hint ?? 'Ej. Mi Tienda Express',
        icon = icon ?? 'store_rounded',
        label = label ?? 'Nombre Comercial',
        isPassword = isPassword ?? true;

  final FormFieldModel? model;
  final String hint;
  final String icon;
  final String label;
  final bool isPassword;

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  late FormFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = widget.model ?? createModel(context, () => FormFieldModel());
  }

  @override
  void dispose() {
    if (widget.model == null) {
      _model.maybeDispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          valueOrDefault<String>(
            widget.label,
            'Nombre Comercial',
          ),
          style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                fontFamily: "Space Grotesk",
                color: Colors.black,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
        ),
        wrapWithModel(
          model: _model.textFieldModel,
          updateCallback: () => safeSetState(() {}),
          child: TextFieldWidget(
            model: _model.textFieldModel,
            label: '',
            labelPresent: false,
            helper: '',
            helperPresent: false,
            leadingIcon: Icon(
              Icons.store_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24,
            ),
            leadingIconPresent: false,
            trailingIconPresent: false,
            hint: valueOrDefault<String>(
              widget.hint,
              'Ej. Mi Tienda Express',
            ),
            value: '',
            onSubmit: '',
            variant: 'outlined',
            error: false,
            isPassword: widget.isPassword,
          ),
        ),
      ].divide(const SizedBox(height: 4)),
    );
  }
}
