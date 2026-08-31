import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'text_field_model.dart';
export 'text_field_model.dart';

@Preview()
Widget previewTextField() {
  return const TextFieldWidget(
    label: 'Correo Electrónico',
    labelPresent: true,
    hint: 'ejemplo@correo.com',
    leadingIcon: Icon(Icons.email_outlined, size: 20),
    leadingIconPresent: true,
  );
}

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    String? label,
    bool? labelPresent,
    String? helper,
    bool? helperPresent,
    this.leadingIcon,
    bool? leadingIconPresent,
    this.trailingIcon,
    bool? trailingIconPresent,
    String? hint,
    String? value,
    this.onChange,
    String? onSubmit,
    String? variant,
    bool? error,
  }) : label = label ?? '',
       labelPresent = labelPresent ?? false,
       helper = helper ?? '',
       helperPresent = helperPresent ?? false,
       leadingIconPresent = leadingIconPresent ?? false,
       trailingIconPresent = trailingIconPresent ?? false,
       hint = hint ?? 'SlotValue($hint)',
       value = value ?? '',
       onSubmit = onSubmit ?? '',
       variant = variant ?? 'outlined',
       error = error ?? false;

  final String label;
  final bool labelPresent;
  final String helper;
  final bool helperPresent;
  final Widget? leadingIcon;
  final bool leadingIconPresent;
  final Widget? trailingIcon;
  final bool trailingIconPresent;
  final String hint;
  final String value;
  final void Function(String)? onChange;
  final String onSubmit;
  final String variant;
  final bool error;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TextFieldModel());

    _model.inputTextController ??= TextEditingController(text: widget.value);
    _model.inputTextController?.addListener(() {
      if (widget.onChange != null) {
        widget.onChange!(_model.inputTextController!.text);
      }
    });
    _model.inputFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.labelPresent)
          Text(
            widget.label,
            style: FlutterFlowTheme.of(context).labelMedium.copyWith(
              fontFamily: "Space Grotesk",
              color: widget.error
                  ? FlutterFlowTheme.of(context).error
                  : FlutterFlowTheme.of(context).primaryText,
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
              height: 1.3,
            ),
          ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(() {
              if (valueOrDefault<String>(widget.variant, 'outlined') ==
                  'filled') {
                return FlutterFlowTheme.of(context).secondaryBackground;
              } else if (valueOrDefault<String>(widget.variant, 'outlined') ==
                  'ghost') {
                return Colors.transparent;
              } else {
                return Colors.transparent;
              }
            }(), Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: valueOrDefault<Color>(() {
                if (widget.error) {
                  return FlutterFlowTheme.of(context).error;
                } else if (valueOrDefault<String>(widget.variant, 'outlined') ==
                    'filled') {
                  return Colors.transparent;
                } else if (valueOrDefault<String>(widget.variant, 'outlined') ==
                    'ghost') {
                  return Colors.transparent;
                } else {
                  return FlutterFlowTheme.of(context).alternate;
                }
              }(), FlutterFlowTheme.of(context).alternate),
              width: valueOrDefault<double>(() {
                if (widget.error) {
                  return 1.0;
                } else if (valueOrDefault<String>(widget.variant, 'outlined') ==
                    'filled') {
                  return 1.0;
                } else if (valueOrDefault<String>(widget.variant, 'outlined') ==
                    'ghost') {
                  return 0.0;
                } else {
                  return 1.0;
                }
              }(), 1.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.leadingIconPresent && widget.leadingIcon != null)
                  widget.leadingIcon!,
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _model.inputTextController,
                    focusNode: _model.inputFocusNode,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: valueOrDefault<String>(
                        widget.hint,
                        'Ingrese texto...',
                      ),
                      hintStyle: FlutterFlowTheme.of(context).bodyMedium
                          .copyWith(
                            fontFamily: "Poppins",
                            color: Colors.black,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(
                              context,
                            ).bodyMedium.fontWeight,
                            height: 1.5,
                          ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      fontFamily: "Poppins",
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(
                        context,
                      ).bodyMedium.fontWeight,
                      height: 1.5,
                    ),
                    validator: _model.inputTextControllerValidator == null
                        ? null
                        : (value) => _model.inputTextControllerValidator!(
                            context,
                            value,
                          ),
                  ),
                ),
                if (widget.trailingIconPresent && widget.trailingIcon != null)
                  widget.trailingIcon!,
              ],
            ),
          ),
        ),
        if (widget.helperPresent)
          Text(
            widget.helper,
            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
              fontFamily: "Poppins",
              color: widget.error
                  ? FlutterFlowTheme.of(context).error
                  : FlutterFlowTheme.of(context).secondaryText,
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
              height: 1.4,
            ),
          ),
      ].divide(const SizedBox(height: 6)),
    );
  }
}
