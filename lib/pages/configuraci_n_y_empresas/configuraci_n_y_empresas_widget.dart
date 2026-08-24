import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child5/bottom_nav_child5_widget.dart';
import 'package:multi_p_o_s/components/business_card/business_card_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/settings_tile/settings_tile_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:multi_p_o_s/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'configuraci_n_y_empresas_model.dart';
export 'configuraci_n_y_empresas_model.dart';

class ConfiguraciNYEmpresasWidget extends StatefulWidget {
  const ConfiguraciNYEmpresasWidget({super.key});

  static String routeName = 'ConfiguraciNYEmpresas';
  static String routePath = '/configuraciNYEmpresas';

  @override
  State<ConfiguraciNYEmpresasWidget> createState() =>
      _ConfiguraciNYEmpresasWidgetState();
}

class _ConfiguraciNYEmpresasWidgetState
    extends State<ConfiguraciNYEmpresasWidget> {
  late ConfiguraciNYEmpresasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfiguraciNYEmpresasModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Configuración',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .copyWith(
                                  font: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                  height: 1.25,
                                ),
                              ),
                              Text(
                                'Gestión de MultiPOS y Empresas',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .copyWith(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                  height: 1.4,
                                ),
                              ),
                            ].divide(SizedBox(height: 4)),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 40,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.help_outline_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Mis Empresas',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .copyWith(
                                        font: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                        height: 1.3,
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.goNamed(
                                            RegistroDeNegocioWidget.routeName);
                                      },
                                      child: wrapWithModel(
                                        model: _model.buttonModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ButtonWidget(
                                          icon: Icon(
                                            Icons.add_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 24,
                                          ),
                                          iconPresent: true,
                                          iconEndPresent: false,
                                          content: 'Nueva Empresa',
                                          variant: 'ghost',
                                          size: 'small',
                                          fullWidth: false,
                                          loading: false,
                                          disabled: false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                wrapWithModel(
                                  model: _model.businessCardModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BusinessCardWidget(
                                    name: 'Ferretería El Tornillo',
                                    type: 'Ferretería',
                                    isActive: true,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.businessCardModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BusinessCardWidget(
                                    name: 'Repuestos Central',
                                    type: 'Autopartes',
                                    isActive: false,
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Equipo y Seguridad',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .copyWith(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                    height: 1.3,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.settingsTileModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingsTileWidget(
                                    icon: Icon(
                                      Icons.people_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onSurface,
                                      size: 24,
                                    ),
                                    iconBg:
                                    FlutterFlowTheme.of(context).primary20,
                                    subtitle: 'Gestionar roles y accesos',
                                    target: 'Target',
                                    title: 'Empleados',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.settingsTileModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingsTileWidget(
                                    icon: Icon(
                                      Icons.security_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onSurface,
                                      size: 24,
                                    ),
                                    iconBg: FlutterFlowTheme.of(context)
                                        .secondary20,
                                    subtitle:
                                    'Registro de movimientos críticos',
                                    target: 'Target',
                                    title: 'Auditoría',
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Aplicación',
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .copyWith(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                    height: 1.3,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.settingsTileModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingsTileWidget(
                                    icon: Icon(
                                      Icons.print_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onSurface,
                                      size: 24,
                                    ),
                                    iconBg:
                                    FlutterFlowTheme.of(context).accent20,
                                    subtitle: 'Configurar Bluetooth/Red',
                                    target: 'Target',
                                    title: 'Impresora y Tickets',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.settingsTileModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingsTileWidget(
                                    icon: Icon(
                                      Icons.description_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .onSurface,
                                      size: 24,
                                    ),
                                    iconBg: Color(0x3300C2FF),
                                    subtitle: 'Configuración fiscal',
                                    target: 'Target',
                                    title: 'Impuestos y NIT',
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .surfaceVariant30,
                                borderRadius: BorderRadius.circular(24),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .tertiary,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment:
                                            AlignmentDirectional(0, 0),
                                            child: Text(
                                              'AR',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .copyWith(
                                                font: GoogleFonts
                                                    .spaceGrotesk(
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .fontStyle,
                                                ),
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .onAccent,
                                                fontSize: 15.2,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontStyle,
                                                height: 1.3,
                                              ),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Alex Rivera',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .titleMedium
                                                    .copyWith(
                                                  font:
                                                  GoogleFonts.urbanist(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .titleMedium
                                                        .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleMedium
                                                      .fontStyle,
                                                  height: 1.4,
                                                ),
                                              ),
                                              Text(
                                                'Rol: Propietario',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .copyWith(
                                                  font: GoogleFonts
                                                      .spaceGrotesk(
                                                    fontWeight:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelSmall
                                                        .fontWeight,
                                                    fontStyle:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .labelSmall
                                                        .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .labelSmall
                                                      .fontWeight,
                                                  fontStyle:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .labelSmall
                                                      .fontStyle,
                                                  height: 1.2,
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 4)),
                                          ),
                                        ].divide(SizedBox(width: 16)),
                                      ),
                                      Divider(
                                        height: 16,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.goNamed(
                                              InicioDeSesiNWidget.routeName);
                                        },
                                        child: wrapWithModel(
                                          model: _model.buttonModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: ButtonWidget(
                                            icon: Icon(
                                              Icons.logout_rounded,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                              size: 24,
                                            ),
                                            iconPresent: true,
                                            iconEndPresent: false,
                                            content: 'Cerrar Sesión',
                                            variant: 'destructive',
                                            size: 'medium',
                                            fullWidth: true,
                                            loading: false,
                                            disabled: false,
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 16)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'MultiPOS v2.4.0',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .copyWith(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .onBackground,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      height: 1.2,
                                    ),
                                  ),
                                  Text(
                                    'Hecho con ❤️ para tu negocio',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .copyWith(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .onBackground,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      height: 1.2,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 4)),
                              ),
                            ),
                          ].divide(SizedBox(height: 24)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 1),
              child: Container(
                child: wrapWithModel(
                  model: _model.bottomNavModel,
                  updateCallback: () => safeSetState(() {}),
                  child: BottomNavWidget(
                    child: () => BottomNavChild5Widget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
