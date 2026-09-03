import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/pages/registro_de_negocio/registro_de_negocio_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
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
        
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isCompact ? 24.0 : 40.0, vertical: 16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      
                      // SECCIÓN LOGOTIPO
                      Column(
                        mainAxisSize: MainAxisSize.min,
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
                              borderRadius: BorderRadius.circular(24),
                            ),
                            alignment: const AlignmentDirectional(0, 0),
                            child: const Icon(
                              Icons.store_rounded,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'MultiPOS',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).headlineLarge.copyWith(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.0,
                              height: 1.1,
                            ),
                          ),
                          Text(
                            'Punto de Venta Inteligente',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                              fontFamily: "Poppins",
                              color: Colors.white70,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // TARJETA DE LOGIN (Backdrop Filter)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).surface40.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Bienvenido',
                                    style: FlutterFlowTheme.of(context).titleLarge.copyWith(
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.bold,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  wrapWithModel(
                                    model: _model.textFieldModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TextFieldWidget(
                                      model: _model.textFieldModel1,
                                      label: 'Usuario',
                                      labelPresent: true,
                                      leadingIcon: const Icon(Icons.person_outline_rounded, size: 24),
                                      leadingIconPresent: true,
                                      hint: 'Nombre de usuario',
                                      variant: 'filled',
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  wrapWithModel(
                                    model: _model.textFieldModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TextFieldWidget(
                                      model: _model.textFieldModel2,
                                      label: 'Contraseña',
                                      labelPresent: true,
                                      leadingIcon: const Icon(Icons.lock_outline_rounded, size: 24),
                                      leadingIconPresent: true,
                                      hint: '••••••••',
                                      variant: 'filled',
                                      isPassword: true,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: wrapWithModel(
                                      model: _model.buttonModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: const ButtonWidget(
                                        content: '¿Olvidaste tu contraseña?',
                                        variant: 'ghost',
                                        size: 'small',
                                        fullWidth: false,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  wrapWithModel(
                                    model: _model.buttonModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      content: 'Iniciar Sesión',
                                      variant: 'primary',
                                      size: 'large',
                                      fullWidth: true,
                                      onTap: () async {
                                        final username = _model.textFieldModel1.inputTextController?.text.trim() ?? '';
                                        final password = _model.textFieldModel2.inputTextController?.text ?? '';

                                        if (username.isEmpty || password.isEmpty) {
                                          if (mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Por favor ingrese usuario y contraseña')),
                                            );
                                          }
                                          return;
                                        }

                                        final user = await DatabaseHelper.instance.login(
                                          username,
                                          password,
                                        );

                                        if (user != null) {
                                          final prefs = await SharedPreferences.getInstance();
                                          await prefs.setInt('empresa_id', user['empresa_id']);
                                          await prefs.setInt('usuario_id', user['id']);
                                          await prefs.setString('user_role', user['rol'] ?? 'admin');
                                          await prefs.setString('user_name', user['nombre'] ?? user['username'] ?? '');
                                          
                                          if (!mounted) return;
                                          context.goNamed(PanelPrincipalWidget.routeName);
                                        } else {
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Usuario o contraseña incorrectos')),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // SECCIÓN INFERIOR (Registro + Seguridad)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '¿Eres nuevo?',
                            style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                              fontFamily: "Poppins",
                              color: Colors.white70,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.buttonModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              content: 'Registrar mi Negocio',
                              variant: 'outline',
                              size: 'medium',
                              fullWidth: false,
                              onTap: () async {
                                context.goNamed(RegistroDeNegocioWidget.routeName);
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.verified_user_rounded, color: FlutterFlowTheme.of(context).success, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'Conexión Segura Encriptada',
                                style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                                  color: Colors.white60,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'v2.4.0 • MultiPOS Bolivia',
                            style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                              color: Colors.white38,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
