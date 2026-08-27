import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:multi_p_o_s/index.dart';
import 'package:flutter/material.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 600;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            isCompact ? 20 : 32,
            isCompact ? 24 : 32,
            isCompact ? 20 : 32,
            isCompact ? 24 : 32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: isCompact ? 8 : 48),
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
                              offset: const Offset(0, 8),
                              spreadRadius: 0,
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primary,
                              FlutterFlowTheme.of(context).secondary,
                            ],
                            stops: const [0, 1],
                            begin: const AlignmentDirectional(1, 1),
                            end: const AlignmentDirectional(-1, -1),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(24),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                        alignment: const AlignmentDirectional(0, 0),
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
                            style: FlutterFlowTheme.of(context).headlineLarge
                                .copyWith(
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.w900,
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  letterSpacing: 0.0,
                                  height: 1.2,
                                ),
                          ),
                          Text(
                            'Punto de Venta Inteligente',
                            style: FlutterFlowTheme.of(context).bodyMedium
                                .copyWith(
                                  fontFamily: "Poppins",
                                  color: FlutterFlowTheme.of(
                                    context,
                                  ).secondaryText,
                                  letterSpacing: 0.0,
                                  height: 1.5,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4)),
                      ),
                    ].divide(const SizedBox(height: 16)),
                  ),
                  SizedBox(height: isCompact ? 28 : 48),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).surface40,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32),
                          ),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isCompact ? 20 : 32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Bienvenido',
                                style: FlutterFlowTheme.of(context).titleLarge
                                    .copyWith(
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.bold,
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).primaryText,
                                      letterSpacing: 0.0,
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
                                    child: const TextFieldWidget(
                                      label: 'Usuario',
                                      labelPresent: true,
                                      helper: '',
                                      helperPresent: false,
                                      leadingIcon: Icon(
                                        Icons.person_outline_rounded,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      wrapWithModel(
                                        model: _model.textFieldModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: const TextFieldWidget(
                                          label: 'Contraseña',
                                          labelPresent: true,
                                          helper: '',
                                          helperPresent: false,
                                          leadingIcon: Icon(
                                            Icons.lock_outline_rounded,
                                            size: 24,
                                          ),
                                          leadingIconPresent: true,
                                          trailingIcon: Icon(
                                            Icons.visibility_off_rounded,
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
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: wrapWithModel(
                                            model: _model.buttonModel1,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: const ButtonWidget(
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
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 4)),
                                  ),
                                ].divide(const SizedBox(height: 16)),
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  GoRouter.of(
                                    context,
                                  ).goNamed(PanelPrincipalWidget.routeName);
                                },
                                child: wrapWithModel(
                                  model: _model.buttonModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: const ButtonWidget(
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
                            ].divide(const SizedBox(height: 24)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isCompact ? 24 : 32),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '¿Eres nuevo?',
                        style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                          fontFamily: "Poppins",
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(
                            context,
                          ).bodySmall.fontWeight,
                          fontStyle: FlutterFlowTheme.of(
                            context,
                          ).bodySmall.fontStyle,
                          height: 1.4,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          GoRouter.of(
                            context,
                          ).goNamed(RegistroDeNegocioWidget.routeName);
                        },
                        child: wrapWithModel(
                          model: _model.buttonModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: const ButtonWidget(
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
                    ].divide(const SizedBox(height: 8)),
                  ),
                  SizedBox(height: isCompact ? 24 : 64),
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
                            style: FlutterFlowTheme.of(context).labelSmall
                                .copyWith(
                                  fontFamily: "Space Grotesk",
                                  color: FlutterFlowTheme.of(
                                    context,
                                  ).secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(
                                    context,
                                  ).labelSmall.fontWeight,
                                  height: 1.2,
                                ),
                          ),
                        ].divide(const SizedBox(width: 4)),
                      ),
                      Text(
                        'v2.4.0 • MultiPOS Bolivia',
                        style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                          fontFamily: "Space Grotesk",
                          color: FlutterFlowTheme.of(context).accent3,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(
                            context,
                          ).labelSmall.fontWeight,
                          fontStyle: FlutterFlowTheme.of(
                            context,
                          ).labelSmall.fontStyle,
                          height: 1.2,
                        ),
                      ),
                    ].divide(const SizedBox(height: 4)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
