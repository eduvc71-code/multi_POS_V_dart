import 'package:multi_p_o_s/components/business_type_card/business_type_card_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/checkbox/checkbox_widget.dart';
import 'package:multi_p_o_s/components/form_field/form_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/pages/inicio_de_sesi_n/inicio_de_sesi_n_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:multi_p_o_s/database/database_helper.dart';

import 'registro_de_negocio_model.dart';
export 'registro_de_negocio_model.dart';

@Preview()
Widget previewRegistroDeNegocio() {
  return const RegistroDeNegocioWidget();
}

class RegistroDeNegocioWidget extends StatefulWidget {
  const RegistroDeNegocioWidget({super.key});

  static String routeName = 'RegistroDeNegocio';
  static String routePath = '/registroDeNegocio';

  @override
  State<RegistroDeNegocioWidget> createState() =>
      _RegistroDeNegocioWidgetState();
}

class _RegistroDeNegocioWidgetState extends State<RegistroDeNegocioWidget> {
  late RegistroDeNegocioModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegistroDeNegocioModel());
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
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // BLOQUE 1: CABECERA (Logo/Título)
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(24, 32, 24, 32),
                          child: Column(
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
                                      blurRadius: 20,
                                      color: FlutterFlowTheme.of(context).primary27,
                                      offset: const Offset(0, 8),
                                      spreadRadius: 0,
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      FlutterFlowTheme.of(context).primary,
                                      FlutterFlowTheme.of(context).secondary
                                    ],
                                    stops: const [0, 1],
                                    begin: const AlignmentDirectional(1, 1),
                                    end: const AlignmentDirectional(-1, -1),
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  shape: BoxShape.rectangle,
                                ),
                                alignment: const AlignmentDirectional(0, 0),
                                child: const Icon(
                                  Icons.store_rounded,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'MultiPOS',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .copyWith(
                                          fontFamily: "Urbanist",
                                          color: FlutterFlowTheme.of(context).primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w900,
                                          height: 1.2,
                                        ),
                                  ),
                                  Text(
                                    'Configura tu nuevo negocio',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .copyWith(
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontWeight,
                                          height: 1.5,
                                        ),
                                  ),
                                ].divide(const SizedBox(height: 4)),
                              ),
                            ].divide(const SizedBox(height: 16)),
                          ),
                        ),
                      ),
                      Spacer(flex: 2),
                      // BLOQUE 2: CUERPO (Formularios/Cards)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.business_center_rounded,
                                    color: FlutterFlowTheme.of(context).secondary,
                                    size: 20,
                                  ),
                                  Text(
                                    'Información del Negocio',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .copyWith(
                                          fontFamily: "Urbanist",
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                        ),
                                  ),
                                ].divide(const SizedBox(width: 8)),
                              ),
                              wrapWithModel(
                                model: _model.formFieldModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: const FormFieldWidget(
                                  hint: 'Ej. Mi Tienda Express',
                                  icon: 'store_rounded',
                                  label: 'Nombre Comercial',
                                  isPassword: true,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Tipo de Negocio',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .copyWith(
                                          fontFamily: "Space Grotesk",
                                          color: Colors.black,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3,
                                        ),
                                  ),
                                  Column(
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
                                              model: _model.businessTypeCardModel1,
                                              updateCallback: () => safeSetState(() {}),
                                              child: BusinessTypeCardWidget(
                                                color: FlutterFlowTheme.of(context).primary,
                                                icon: Icon(
                                                  Icons.shopping_basket_rounded,
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  size: 24,
                                                ),
                                                title: 'Tienda',
                                                selected: _model.selectedBusinessType == 'Tienda',
                                                onTap: () => setState(() => _model.selectedBusinessType = 'Tienda'),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: wrapWithModel(
                                              model: _model.businessTypeCardModel2,
                                              updateCallback: () => safeSetState(() {}),
                                              child: BusinessTypeCardWidget(
                                                color: FlutterFlowTheme.of(context).secondary,
                                                icon: Icon(
                                                  Icons.build_rounded,
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  size: 24,
                                                ),
                                                title: 'Ferretería',
                                                selected: _model.selectedBusinessType == 'Ferretería',
                                                onTap: () => setState(() => _model.selectedBusinessType = 'Ferretería'),
                                              ),
                                            ),
                                          ),
                                        ].divide(const SizedBox(width: 8)),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: wrapWithModel(
                                              model: _model.businessTypeCardModel3,
                                              updateCallback: () => safeSetState(() {}),
                                              child: BusinessTypeCardWidget(
                                                color: FlutterFlowTheme.of(context).tertiary,
                                                icon: Icon(
                                                  Icons.directions_car_rounded,
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  size: 24,
                                                ),
                                                title: 'Autopartes',
                                                selected: _model.selectedBusinessType == 'Autopartes',
                                                onTap: () => setState(() => _model.selectedBusinessType = 'Autopartes'),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: wrapWithModel(
                                              model: _model.businessTypeCardModel4,
                                              updateCallback: () => safeSetState(() {}),
                                              child: BusinessTypeCardWidget(
                                                color: FlutterFlowTheme.of(context).success,
                                                icon: Icon(
                                                  Icons.two_wheeler_rounded,
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  size: 24,
                                                ),
                                                title: 'Motopartes',
                                                selected: _model.selectedBusinessType == 'Motopartes',
                                                onTap: () => setState(() => _model.selectedBusinessType = 'Motopartes'),
                                              ),
                                            ),
                                          ),
                                        ].divide(const SizedBox(width: 8)),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: wrapWithModel(
                                              model: _model.businessTypeCardModel5,
                                              updateCallback: () => safeSetState(() {}),
                                              child: BusinessTypeCardWidget(
                                                color: const Color(0xFF6200EA),
                                                icon: Icon(
                                                  Icons.local_pharmacy_rounded,
                                                  color: FlutterFlowTheme.of(context).primary,
                                                  size: 24,
                                                ),
                                                title: 'Farmacia',
                                                selected: _model.selectedBusinessType == 'Farmacia',
                                                onTap: () => setState(() => _model.selectedBusinessType = 'Farmacia'),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                        ].divide(const SizedBox(width: 8)),
                                      ),
                                    ].divide(const SizedBox(height: 8)),
                                  ),
                                ].divide(const SizedBox(height: 8)),
                              ),
                              wrapWithModel(
                                model: _model.formFieldModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: const FormFieldWidget(
                                  hint: '123456789',
                                  icon: 'description_rounded',
                                  label: 'NIT / Identificación Fiscal (Opcional)',
                                  isPassword: true,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.formFieldModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: const FormFieldWidget(
                                  hint: '70000000',
                                  icon: 'phone_rounded',
                                  label: 'Teléfono de Contacto',
                                  isPassword: true,
                                ),
                              ),
                            ].divide(const SizedBox(height: 16)),
                          ),
                          const Divider(
                            height: 16,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Color(0xFFE0E3E7),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_circle_rounded,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 20,
                                  ),
                                  Text(
                                    'Cuenta del Propietario',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .copyWith(
                                          fontFamily: "Urbanist",
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                        ),
                                  ),
                                ].divide(const SizedBox(width: 8)),
                              ),
                              wrapWithModel(
                                model: _model.formFieldModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: const FormFieldWidget(
                                  hint: 'Nombre y Apellidos',
                                  icon: 'person_rounded',
                                  label: 'Nombre Completo',
                                  isPassword: true,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.formFieldModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: const FormFieldWidget(
                                  hint: 'usuario123',
                                  icon: 'alternate_email_rounded',
                                  label: 'Nombre de Usuario',
                                  isPassword: true,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.formFieldModel6,
                                updateCallback: () => safeSetState(() {}),
                                child: const FormFieldWidget(
                                  hint: 'Mínimo 8 caracteres',
                                  icon: 'lock_rounded',
                                  label: 'Contraseña',
                                  isPassword: true,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.formFieldModel7,
                                updateCallback: () => safeSetState(() {}),
                                child: const FormFieldWidget(
                                  hint: 'Repite tu contraseña',
                                  icon: 'lock_clock_rounded',
                                  label: 'Confirmar Contraseña',
                                  isPassword: true,
                                ),
                              ),
                            ].divide(const SizedBox(height: 16)),
                          ),
                          wrapWithModel(
                            model: _model.checkboxModel,
                            updateCallback: () => safeSetState(() {}),
                            child: CheckboxWidget(
                              label: 'Acepto los términos y condiciones de MultiPOS',
                              subtitle: 'Receive weekly updates',
                              color: FlutterFlowTheme.of(context).primary,
                              isChecked: true,
                              hasSubtitle: false,
                              disabled: false,
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 2),
                      // BLOQUE 3: FOOTER (Botones finales/Links)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          wrapWithModel(
                            model: _model.buttonModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              iconPresent: true,
                              iconEndPresent: false,
                              content: 'Finalizar Registro',
                              variant: 'primary',
                              size: 'large',
                              fullWidth: true,
                              loading: false,
                              disabled: false,
                              onTap: () async {
                                print('Finalizando registro...');
                                try {
                                  await DatabaseHelper.instance.clearDatabase();
                                  await DatabaseHelper.instance.populateInventory(_model.selectedBusinessType);
                                  if (mounted) {
                                    context.goNamed(PanelPrincipalWidget.routeName);
                                  }
                                } catch (e) {
                                  print('Error: $e');
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '¿Ya tienes un negocio?',
                                  style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        height: 1.4,
                                      ),
                                ),
                                wrapWithModel(
                                  model: _model.buttonModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: ButtonWidget(
                                    iconPresent: false,
                                    iconEndPresent: false,
                                    content: 'Iniciar Sesion',
                                    variant: 'ghost',
                                    size: 'small',
                                    fullWidth: false,
                                    loading: false,
                                    disabled: false,
                                    onTap: () async {
                                      GoRouter.of(context)
                                          .goNamed(InicioDeSesionWidget.routeName);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
