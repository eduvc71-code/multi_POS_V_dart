import 'package:multi_p_o_s/components/business_type_card/business_type_card_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/checkbox/checkbox_widget.dart';
import 'package:multi_p_o_s/components/form_field/form_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/pages/inicio_de_sesi_n/inicio_de_sesi_n_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _populateStandardInventory = false;

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
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MultiPOS ',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .copyWith(
                                    fontFamily: "Urbanist",
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            Text(
                              '| Configura tu nuevo negocio',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .copyWith(
                                    fontFamily: "Poppins",
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                      const SizedBox(height: 8),
                      // BLOQUE 2: CUERPO (Formularios/Cards)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
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
                                        size: 18,
                                      ),
                                      Text(
                                        'Información del Negocio',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .copyWith(
                                              fontFamily: "Urbanist",
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ].divide(const SizedBox(width: 8)),
                                  ),
                                  wrapWithModel(
                                    model: _model.formFieldModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: FormFieldWidget(
                                      model: _model.formFieldModel1,
                                      hint: 'Nombre Comercial',
                                      icon: 'store_rounded',
                                      label: 'Nombre Comercial',
                                      isPassword: false,
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
                                              fontWeight: FontWeight.w600,
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
                                    ].divide(const SizedBox(height: 4)),
                                  ),
                                  wrapWithModel(
                                    model: _model.formFieldModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: FormFieldWidget(
                                      model: _model.formFieldModel2,
                                      hint: 'NIT / ID Fiscal',
                                      icon: 'description_rounded',
                                      label: 'NIT (Opcional)',
                                      isPassword: false,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.formFieldModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: FormFieldWidget(
                                      model: _model.formFieldModel3,
                                      hint: 'Teléfono',
                                      icon: 'phone_rounded',
                                      label: 'Teléfono',
                                      isPassword: false,
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 8)),
                              ),
                              const Divider(height: 12, thickness: 1, color: Color(0xFFE0E3E7)),
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
                                        size: 18,
                                      ),
                                      Text(
                                        'Cuenta Propietario',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .copyWith(
                                              fontFamily: "Urbanist",
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ].divide(const SizedBox(width: 8)),
                                  ),
                                  wrapWithModel(
                                    model: _model.formFieldModel4,
                                    updateCallback: () => safeSetState(() {}),
                                    child: FormFieldWidget(
                                      model: _model.formFieldModel4,
                                      hint: 'Nombre Completo',
                                      icon: 'person_rounded',
                                      label: 'Nombre Completo',
                                      isPassword: false,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.formFieldModel5,
                                    updateCallback: () => safeSetState(() {}),
                                    child: FormFieldWidget(
                                      model: _model.formFieldModel5,
                                      hint: 'Usuario',
                                      icon: 'alternate_email_rounded',
                                      label: 'Nombre de Usuario',
                                      isPassword: false,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.formFieldModel6,
                                          updateCallback: () => safeSetState(() {}),
                                          child: FormFieldWidget(
                                            model: _model.formFieldModel6,
                                            hint: 'Contraseña',
                                            icon: 'lock_rounded',
                                            label: 'Contraseña',
                                            isPassword: true,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: wrapWithModel(
                                          model: _model.formFieldModel7,
                                          updateCallback: () => safeSetState(() {}),
                                          child: FormFieldWidget(
                                            model: _model.formFieldModel7,
                                            hint: 'Confirmar',
                                            icon: 'lock_clock_rounded',
                                            label: 'Confirmar',
                                            isPassword: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ].divide(const SizedBox(height: 8)),
                              ),
                              CheckboxWidget(
                                label: 'Cargar catálogo estándar para mi rubro',
                                subtitle: 'Carga todos los productos del rubro. Solo 10 tendrán precio y stock inicial.',
                                color: FlutterFlowTheme.of(context).primary,
                                isChecked: _populateStandardInventory,
                                hasSubtitle: true,
                                disabled: false,
                                onTap: () {
                                  setState(() {
                                    _populateStandardInventory = !_populateStandardInventory;
                                  });
                                },
                              ),
                              wrapWithModel(
                                model: _model.checkboxModel,
                                updateCallback: () => safeSetState(() {}),
                                child: CheckboxWidget(
                                  label: 'Acepto los términos y condiciones',
                                  color: FlutterFlowTheme.of(context).primary,
                                  isChecked: true,
                                  hasSubtitle: false,
                                  disabled: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                              size: 'small', // Reducido a small
                              fullWidth: true,
                              loading: false,
                              disabled: false,
                              onTap: () async {
                                print('Finalizando registro...');
                                try {
                                  // Capturar datos de los modelos
                                  final businessName = _model.formFieldModel1.textFieldModel.inputTextController?.text ?? '';
                                  final nit = _model.formFieldModel2.textFieldModel.inputTextController?.text ?? '';
                                  final phone = _model.formFieldModel3.textFieldModel.inputTextController?.text ?? '';
                                  final ownerName = _model.formFieldModel4.textFieldModel.inputTextController?.text ?? '';
                                  final username = _model.formFieldModel5.textFieldModel.inputTextController?.text ?? '';
                                  final password = _model.formFieldModel6.textFieldModel.inputTextController?.text ?? '';

                                  // Llamada al nuevo método de registro multitenancy
                                  final empresaId = await DatabaseHelper.instance.registerFullBusiness(
                                    businessName: businessName,
                                    businessType: _model.selectedBusinessType,
                                    nit: nit, 
                                    phone: phone,
                                    ownerName: ownerName,
                                    username: username,
                                    password: password,
                                    populateStandardInventory: _populateStandardInventory,
                                  );

                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setInt('empresa_id', empresaId);
                                  await prefs.setString('selectedBusinessType', _model.selectedBusinessType);

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
                            padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
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
                                        fontSize: 12,
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
