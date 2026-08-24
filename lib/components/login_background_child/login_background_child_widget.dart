import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:multi_p_o_s/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'login_background_child_model.dart';
export 'login_background_child_model.dart';

class LoginBackgroundChildWidget extends StatefulWidget {
  const LoginBackgroundChildWidget({super.key});

  @override
  State<LoginBackgroundChildWidget> createState() =>
      _LoginBackgroundChildWidgetState();
}

class _LoginBackgroundChildWidgetState
    extends State<LoginBackgroundChildWidget> {
  late LoginBackgroundChildModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginBackgroundChildModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24,
                      color: FlutterFlowTheme.of(context).primary,
                      offset: Offset(
                        0,
                        8,
                      ),
                      spreadRadius: 0,
                    )
                  ],
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      FlutterFlowTheme.of(context).secondary
                    ],
                    stops: [0, 1],
                    begin: AlignmentDirectional(1, 1),
                    end: AlignmentDirectional(-1, -1),
                  ),
                  borderRadius: BorderRadius.circular(24),
                  shape: BoxShape.rectangle,
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Icon(
                  Icons.store_rounded,
                  color: FlutterFlowTheme.of(context).onPrimary,
                  size: 42,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'MultiPOS',
                    style:
                        FlutterFlowTheme.of(context).headlineLarge.copyWith(
                              fontFamily: "Urbanist",
                                fontWeight: FontWeight.w900,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).onPrimary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w900,
                              fontStyle: FlutterFlowTheme.of(context)
                              )
                                  .headlineLarge
                                  .fontStyle,
                              height: 1.2,
                            ),
                  ),
                  Text(
                    'Punto de Venta Inteligente',
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                          fontFamily: "Poppins",
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontStyle,
                          height: 1.5,
                        ),
                  ),
                ].divide(SizedBox(height: 4)),
              ),
            ].divide(SizedBox(height: 16)),
          ),
          Container(
            height: 48,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).surface40,
                  borderRadius: BorderRadius.circular(32),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Bienvenido',
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .copyWith(
                                fontFamily: "Urbanist",
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .fontStyle,
                                height: 1.3,
                              ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.textFieldModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: TextFieldWidget(
                                label: 'Usuario',
                                labelPresent: true,
                                helper: '',
                                helperPresent: false,
                                leadingIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  size: 24,
                                ),
                                leadingIconPresent: true,
                                trailingIconPresent: false,
                                hint: 'Ingresa tu nombre de usuario',
                                value: '',
                                onChange: '',
                                onSubmit: '',
                                variant: 'filled',
                                error: false,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wrapWithModel(
                                  model: _model.textFieldModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TextFieldWidget(
                                    label: 'Contraseña',
                                    labelPresent: true,
                                    helper: '',
                                    helperPresent: false,
                                    leadingIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24,
                                    ),
                                    leadingIconPresent: true,
                                    trailingIcon: Icon(
                                      Icons.visibility_off_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24,
                                    ),
                                    trailingIconPresent: true,
                                    hint: '••••••••',
                                    value: '',
                                    onChange: '',
                                    onSubmit: '',
                                    variant: 'filled',
                                    error: false,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    wrapWithModel(
                                      model: _model.buttonModel1,
                                      updateCallback: () =>
                                          safeSetState(() {}),
                                      child: ButtonWidget(
                                        iconPresent: false,
                                        iconEndPresent: false,
                                        content:
                                            '¿Olvidaste tu contraseña?',
                                        variant: 'ghost',
                                        size: 'small',
                                        fullWidth: false,
                                        loading: false,
                                        disabled: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ].divide(SizedBox(height: 4)),
                            ),
                          ].divide(SizedBox(height: 16)),
                        ),
                        Container(
                          height: 8,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.goNamed(PanelPrincipalWidget.routeName);
                          },
                          child: wrapWithModel(
                            model: _model.buttonModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              iconPresent: false,
                              iconEndPresent: false,
                              content: 'Iniciar Sesión',
                              variant: 'primary',
                              size: 'large',
                              fullWidth: true,
                              loading: false,
                              disabled: false,
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 24)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 32,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '¿Eres nuevo?',
                style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                      fontFamily: "Poppins",
                        fontWeight: FlutterFlowTheme.of(context)
                            .bodySmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .bodySmall
                            .fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      height: 1.4,
                    ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.goNamed(RegistroDeNegocioWidget.routeName);
                },
                child: wrapWithModel(
                  model: _model.buttonModel3,
                  updateCallback: () => safeSetState(() {}),
                  child: ButtonWidget(
                    iconPresent: false,
                    iconEndPresent: false,
                    content: 'Registrar mi Negocio',
                    variant: 'outline',
                    size: 'medium',
                    fullWidth: false,
                    loading: false,
                    disabled: false,
                  ),
                ),
              ),
            ].divide(SizedBox(height: 8)),
          ),
          Spacer(flex: 2),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_user_rounded,
                    color: FlutterFlowTheme.of(context).success,
                    size: 14,
                  ),
                  Text(
                    'Conexión Segura Encriptada',
                    style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                          fontFamily: "Space Grotesk",
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelSmall
                              .fontStyle,
                          height: 1.2,
                        ),
                  ),
                ].divide(SizedBox(width: 4)),
              ),
              Text(
                'v2.4.0 • MultiPOS Bolivia',
                style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                      fontFamily: "Space Grotesk",
                        fontWeight: FlutterFlowTheme.of(context)
                            .labelSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .labelSmall
                            .fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).accent3,
                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(context)
                          .labelSmall
                          .fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      height: 1.2,
                    ),
              ),
            ].divide(SizedBox(height: 4)),
          ),
        ],
      ),
    );
  }
}