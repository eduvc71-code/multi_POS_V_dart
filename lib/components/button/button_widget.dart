import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'button_model.dart';
export 'button_model.dart';

@Preview()
Widget previewButtonPrimary() {
  return const ButtonWidget(
    content: 'Botón Primario',
    variant: 'primary',
  );
}

@Preview()
Widget previewButtonSecondary() {
  return const ButtonWidget(
    content: 'Botón Secundario',
    variant: 'secondary',
  );
}

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    this.icon,
    bool? iconPresent,
    this.iconEnd,
    bool? iconEndPresent,
    String? content,
    String? variant,
    String? size,
    bool? fullWidth,
    bool? loading,
    bool? disabled,
    this.onTap,
  }) : iconPresent = iconPresent ?? true,
       iconEndPresent = iconEndPresent ?? false,
       content = content ?? 'Finalizar Registro',
       variant = variant ?? 'primary',
       size = size ?? 'large',
       fullWidth = fullWidth ?? true,
       loading = loading ?? false,
       disabled = disabled ?? false;

  final Widget? icon;
  final bool iconPresent;
  final Widget? iconEnd;
  final bool iconEndPresent;
  final String content;
  final String variant;
  final String size;
  final bool fullWidth;
  final bool loading;
  final bool disabled;
  final VoidCallback? onTap;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  late ButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonContent = Opacity(
      opacity: valueOrDefault<double>(
        valueOrDefault<bool>(widget.disabled, false) ? 0.55 : 1.0,
        1.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(() {
            if (valueOrDefault<String>(widget.variant, 'primary') ==
                'secondary') {
              return FlutterFlowTheme.of(context).secondary;
            } else if (valueOrDefault<String>(widget.variant, 'primary') ==
                'outline') {
              return Colors.transparent;
            } else if (valueOrDefault<String>(widget.variant, 'primary') ==
                'ghost') {
              return Colors.transparent;
            } else if (valueOrDefault<String>(widget.variant, 'primary') ==
                'destructive') {
              return FlutterFlowTheme.of(context).error;
            } else {
              return FlutterFlowTheme.of(context).primary;
            }
          }(), FlutterFlowTheme.of(context).primary),
          borderRadius: BorderRadius.circular(
            valueOrDefault<double>(() {
              if (valueOrDefault<String>(widget.size, 'large') == 'small') {
                return 8.0;
              } else if (valueOrDefault<String>(widget.size, 'large') ==
                  'large') {
                return 24.0;
              } else {
                return 12.0;
              }
            }(), 24.0),
          ),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: valueOrDefault<Color>(
              valueOrDefault<String>(widget.variant, 'primary') == 'outline'
                  ? FlutterFlowTheme.of(context).alternate
                  : Colors.transparent,
              Colors.transparent,
            ),
            width: valueOrDefault<double>(
              valueOrDefault<String>(widget.variant, 'primary') == 'outline'
                  ? 1.0
                  : 0.0,
              0.0,
            ),
          ),
        ),
        child: Stack(
          alignment: const AlignmentDirectional(0, 0),
          children: [
            Opacity(
              opacity: valueOrDefault<double>(
                valueOrDefault<bool>(widget.loading, false) ? 0.0 : 1.0,
                1.0,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  valueOrDefault<double>(() {
                    if (valueOrDefault<String>(widget.size, 'large') ==
                        'small') {
                      return 16.0;
                    } else if (valueOrDefault<String>(widget.size, 'large') ==
                        'large') {
                      return 32.0;
                    } else {
                      return 24.0;
                    }
                  }(), 32.0),
                  valueOrDefault<double>(() {
                    if (valueOrDefault<String>(widget.size, 'large') ==
                        'small') {
                      return 4.0;
                    } else if (valueOrDefault<String>(widget.size, 'large') ==
                        'large') {
                      return 16.0;
                    } else {
                      return 8.0;
                    }
                  }(), 16.0),
                  valueOrDefault<double>(() {
                    if (valueOrDefault<String>(widget.size, 'large') ==
                        'small') {
                      return 16.0;
                    } else if (valueOrDefault<String>(widget.size, 'large') ==
                        'large') {
                      return 32.0;
                    } else {
                      return 24.0;
                    }
                  }(), 32.0),
                  valueOrDefault<double>(() {
                    if (valueOrDefault<String>(widget.size, 'large') ==
                        'small') {
                      return 4.0;
                    } else if (valueOrDefault<String>(widget.size, 'large') ==
                        'large') {
                      return 16.0;
                    } else {
                      return 8.0;
                    }
                  }(), 16.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.iconPresent && widget.icon != null) widget.icon!,
                    Text(
                      valueOrDefault<String>(
                        widget.content,
                        'Finalizar Registro',
                      ),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                            fontFamily: "Space Grotesk",
                            color: valueOrDefault<Color>(() {
                              if (valueOrDefault<String>(
                                    widget.variant,
                                    'primary',
                                  ) ==
                                  'secondary') {
                                return FlutterFlowTheme.of(context)
                                    .onSecondary;
                              } else if (valueOrDefault<String>(
                                    widget.variant,
                                    'primary',
                                  ) ==
                                  'outline') {
                                return FlutterFlowTheme.of(context).primaryText;
                              } else if (valueOrDefault<String>(
                                    widget.variant,
                                    'primary',
                                  ) ==
                                  'ghost') {
                                return FlutterFlowTheme.of(context).primary;
                              } else if (valueOrDefault<String>(
                                    widget.variant,
                                    'primary',
                                  ) ==
                                  'destructive') {
                                return FlutterFlowTheme.of(context).error;
                              } else {
                                return FlutterFlowTheme.of(context).onPrimary;
                              }
                            }(), FlutterFlowTheme.of(context).onPrimary),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(
                              context,
                            ).labelMedium.fontWeight,
                            height: 1.3,
                          ),
                    ),
                    if (widget.iconEndPresent && widget.iconEnd != null)
                      widget.iconEnd!,
                  ].divide(const SizedBox(width: 8)),
                ),
              ),
            ),
            if (widget.loading)
              CircularPercentIndicator(
                percent: 0,
                radius: 7,
                lineWidth: 2,
                animation: true,
                animateFromLastPercent: true,
                progressColor: valueOrDefault<Color>(() {
                  if (valueOrDefault<String>(widget.variant, 'primary') ==
                      'secondary') {
                    return FlutterFlowTheme.of(context).onSecondary;
                  } else if (valueOrDefault<String>(
                        widget.variant,
                        'primary',
                      ) ==
                      'outline') {
                    return FlutterFlowTheme.of(context).primaryText;
                  } else if (valueOrDefault<String>(
                        widget.variant,
                        'primary',
                      ) ==
                      'ghost') {
                    return FlutterFlowTheme.of(context).primary;
                  } else if (valueOrDefault<String>(
                        widget.variant,
                        'primary',
                      ) ==
                      'destructive') {
                    return FlutterFlowTheme.of(context).error;
                  } else {
                    return FlutterFlowTheme.of(context).onPrimary;
                  }
                }(), FlutterFlowTheme.of(context).onPrimary),
                backgroundColor: FlutterFlowTheme.of(context).alternate,
              ),
          ],
        ),
      ),
    );

    if (widget.onTap != null) {
      return InkWell(
        onTap: (widget.disabled || widget.loading) ? null : widget.onTap,
        child: buttonContent,
      );
    }
    return buttonContent;
  }
}
