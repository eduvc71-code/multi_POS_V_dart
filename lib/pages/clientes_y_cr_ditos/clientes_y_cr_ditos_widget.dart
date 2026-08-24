import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child3/bottom_nav_child3_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/client_card/client_card_widget.dart';
import 'package:multi_p_o_s/components/credit_stat/credit_stat_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'clientes_y_cr_ditos_model.dart';
export 'clientes_y_cr_ditos_model.dart';

class ClientesYCrDitosWidget extends StatefulWidget {
  const ClientesYCrDitosWidget({super.key});

  static String routeName = 'ClientesYCrDitos';
  static String routePath = '/clientesYCrDitos';

  @override
  State<ClientesYCrDitosWidget> createState() => _ClientesYCrDitosWidgetState();
}

class _ClientesYCrDitosWidgetState extends State<ClientesYCrDitosWidget> {
  late ClientesYCrDitosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientesYCrDitosModel());
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
                    padding: EdgeInsets.all(24),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
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
                                    'Clientes y Créditos',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .copyWith(
                                      fontFamily: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.bold,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      height: 1.25,
                                    ),
                                  ),
                                  Text(
                                    'Gestiona deudas y estados de cuenta',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .copyWith(
                                      fontFamily: GoogleFonts.poppins(
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight:
                                      FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                      height: 1.4,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 4)),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 24,
                                buttonSize: 40,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.person_add_rounded,
                                  color: FlutterFlowTheme.of(context).onPrimary,
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                          wrapWithModel(
                            model: _model.textFieldModel,
                            updateCallback: () => safeSetState(() {}),
                            child: TextFieldWidget(
                              label: '',
                              labelPresent: false,
                              helper: '',
                              helperPresent: false,
                              leadingIcon: Icon(
                                Icons.search,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24,
                              ),
                              leadingIconPresent: true,
                              trailingIconPresent: false,
                              hint: 'Buscar por nombre o QR...',
                              value: '',
                              onChange: '',
                              onSubmit: '',
                              variant: 'filled',
                              error: false,
                            ),
                          ),
                        ].divide(SizedBox(height: 16)),
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.creditStatModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: CreditStatWidget(
                                      icon: Icon(
                                        Icons.payments_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 20,
                                      ),
                                      label: 'Por Cobrar',
                                      tone:
                                      FlutterFlowTheme.of(context).primary,
                                      value: 'Bs. 12.450,00',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.creditStatModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: CreditStatWidget(
                                      icon: Icon(
                                        Icons.warning_amber_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 20,
                                      ),
                                      label: 'Vencidos',
                                      tone: FlutterFlowTheme.of(context).error,
                                      value: 'Bs. 3.120,00',
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 16)),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 16,
                                          ),
                                          Text(
                                            'Todos',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: GoogleFonts.spaceGrotesk(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontStyle,
                                              ),
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                              height: 1.3,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 6)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Con Deuda',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: GoogleFonts.spaceGrotesk(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontStyle,
                                              ),
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                              height: 1.3,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 6)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Al día',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: GoogleFonts.spaceGrotesk(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontStyle,
                                              ),
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                              height: 1.3,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 6)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Suspendidos',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                              fontFamily: GoogleFonts.spaceGrotesk(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .labelMedium
                                                    .fontStyle,
                                              ),
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMedium
                                                  .fontStyle,
                                              height: 1.3,
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 6)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8)),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Directorio de Clientes',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .copyWith(
                                    fontFamily: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.clientCardModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ClientCardWidget(
                                    debt: 'Bs. 450,00',
                                    name: 'Carlos Rodríguez',
                                    isOverdue: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.clientCardModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ClientCardWidget(
                                    debt: 'Bs. 1.200,50',
                                    name: 'María Elena Gómez',
                                    isOverdue: true,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.clientCardModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ClientCardWidget(
                                    debt: 'Bs. 0,00',
                                    name: 'Tienda El Sol',
                                    isOverdue: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.clientCardModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ClientCardWidget(
                                    debt: 'Bs. 85,00',
                                    name: 'Juan Pablo Duarte',
                                    isOverdue: false,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.clientCardModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ClientCardWidget(
                                    debt: 'Bs. 2.340,00',
                                    name: 'Lucía Fernández',
                                    isOverdue: true,
                                  ),
                                ),
                              ].divide(SizedBox(height: 16)),
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primaryBackground,
                      Colors.transparent
                    ],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0, 1),
                    end: AlignmentDirectional(0, -1),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Container(
                    child: wrapWithModel(
                      model: _model.buttonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        icon: Icon(
                          Icons.add_card_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24,
                        ),
                        iconPresent: true,
                        iconEndPresent: false,
                        content: 'Registrar Abono Rápido',
                        variant: 'primary',
                        size: 'large',
                        fullWidth: true,
                        loading: false,
                        disabled: false,
                      ),
                    ),
                  ),
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
                    child: () => BottomNavChild3Widget(),
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
