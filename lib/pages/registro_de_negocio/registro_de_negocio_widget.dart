import 'package:multi_p_o_s/components/business_type_card/business_type_card_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/checkbox/checkbox_widget.dart';
import 'package:multi_p_o_s/components/form_field/form_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:multi_p_o_s/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'registro_de_negocio_model.dart';
export 'registro_de_negocio_model.dart';

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
           backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
           body: SingleChildScrollView(
             primary: false,
             child: Column(
               mainAxisSize: MainAxisSize.min,
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 Container(
                   decoration: BoxDecoration(
                     color: FlutterFlowTheme.of(context).secondaryBackground,
                     borderRadius: BorderRadius.only(
                       bottomLeft: Radius.circular(32),
                       bottomRight: Radius.circular(32),
                     ),
                     shape: BoxShape.rectangle,
                   ),
                   child: Padding(
                     padding: EdgeInsetsDirectional.fromSTEB(24, 32, 24, 32),
                     child: Container(
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
                               color: FlutterFlowTheme.of(context).onSurface,
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
                                       font: GoogleFonts.urbanist(
                                         fontWeight: FontWeight.w900,
                                       ),
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
                                       font: GoogleFonts.poppins(
                                         fontWeight: FlutterFlowTheme.of(context)
                                             .bodyMedium
                                             .fontWeight,
                                       ),
                                       color: FlutterFlowTheme.of(context)
                                           .secondaryText,
                                       letterSpacing: 0.0,
                                       fontWeight: FlutterFlowTheme.of(context)
                                           .bodyMedium
                                           .fontWeight,
                                       height: 1.5,
                                     ),
                               ),
                             ].divide(SizedBox(height: 4)),
                           ),
                         ].divide(SizedBox(height: 16)),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: EdgeInsets.all(24),
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
                                 size: 20,
                               ),
                               Text(
                                 'Información del Negocio',
                                 style: FlutterFlowTheme.of(context)
                                     .titleMedium
                                     .copyWith(
                                       font: GoogleFonts.urbanist(
                                         fontWeight: FontWeight.bold,
                                       ),
                                       color: FlutterFlowTheme.of(context)
                                           .primaryText,
                                       letterSpacing: 0.0,
                                       fontWeight: FontWeight.bold,
                                       height: 1.4,
                                     ),
                               ),
                             ].divide(SizedBox(width: 8)),
                           ),
                           wrapWithModel(
                             model: _model.formFieldModel1,
                             updateCallback: () => safeSetState(() {}),
                             child: FormFieldWidget(
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
                                       font: GoogleFonts.spaceGrotesk(
                                         fontWeight: FontWeight.w600,
                                       ),
                                       color: FlutterFlowTheme.of(context)
                                           .secondaryText,
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
                                           updateCallback: () =>
                                               safeSetState(() {}),
                                           child: BusinessTypeCardWidget(
                                             color: FlutterFlowTheme.of(context)
                                                 .primary,
                                             icon: Icon(
                                               Icons.shopping_basket_rounded,
                                               color: FlutterFlowTheme.of(context)
                                                   .primary,
                                               size: 24,
                                             ),
                                             title: 'Tienda',
                                             selected: true,
                                           ),
                                         ),
                                       ),
                                       Expanded(
                                         flex: 1,
                                         child: wrapWithModel(
                                           model: _model.businessTypeCardModel2,
                                           updateCallback: () =>
                                               safeSetState(() {}),
                                           child: BusinessTypeCardWidget(
                                             color: FlutterFlowTheme.of(context)
                                                 .secondary,
                                             icon: Icon(
                                               Icons.build_rounded,
                                               color: FlutterFlowTheme.of(context)
                                                   .primary,
                                               size: 24,
                                             ),
                                             title: 'Ferretería',
                                             selected: true,
                                           ),
                                         ),
                                       ),
                                     ].divide(SizedBox(width: 8)),
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
                                           updateCallback: () =>
                                               safeSetState(() {}),
                                           child: BusinessTypeCardWidget(
                                             color: FlutterFlowTheme.of(context)
                                                 .tertiary,
                                             icon: Icon(
                                               Icons.directions_car_rounded,
                                               color: FlutterFlowTheme.of(context)
                                                   .primary,
                                               size: 24,
                                             ),
                                             title: 'Autopartes',
                                             selected: true,
                                           ),
                                         ),
                                       ),
                                       Expanded(
                                         flex: 1,
                                         child: wrapWithModel(
                                           model: _model.businessTypeCardModel4,
                                           updateCallback: () =>
                                               safeSetState(() {}),
                                           child: BusinessTypeCardWidget(
                                             color: FlutterFlowTheme.of(context)
                                                 .success,
                                             icon: Icon(
                                               Icons.two_wheeler_rounded,
                                               color: FlutterFlowTheme.of(context)
                                                   .primary,
                                               size: 24,
                                             ),
                                             title: 'Motopartes',
                                             selected: true,
                                           ),
                                         ),
                                       ),
                                     ].divide(SizedBox(width: 8)),
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
                                           updateCallback: () =>
                                               safeSetState(() {}),
                                           child: BusinessTypeCardWidget(
                                             color: Color(0xFF6200EA),
                                             icon: Icon(
                                               Icons.local_pharmacy_rounded,
                                               color: FlutterFlowTheme.of(context)
                                                   .primary,
                                               size: 24,
                                             ),
                                             title: 'Farmacia',
                                             selected: true,
                                           ),
                                         ),
                                       ),
                                       Expanded(
                                         flex: 1,
                                         child: Container(),
                                       ),
                                     ].divide(SizedBox(width: 8)),
                                   ),
                                 ].divide(SizedBox(height: 8)),
                               ),
                             ].divide(SizedBox(height: 8)),
                           ),
                           wrapWithModel(
                             model: _model.formFieldModel2,
                             updateCallback: () => safeSetState(() {}),
                             child: FormFieldWidget(
                               hint: '123456789',
                               icon: 'description_rounded',
                               label: 'NIT / Identificación Fiscal (Opcional)',
                               isPassword: true,
                             ),
                           ),
                           wrapWithModel(
                             model: _model.formFieldModel3,
                             updateCallback: () => safeSetState(() {}),
                             child: FormFieldWidget(
                               hint: '70000000',
                               icon: 'phone_rounded',
                               label: 'Teléfono de Contacto',
                               isPassword: true,
                             ),
                           ),
                         ].divide(SizedBox(height: 16)),
                       ),
                       Divider(
                         height: 16,
                         thickness: 1,
                         indent: 0,
                         endIndent: 0,
                         color: FlutterFlowTheme.of(context).alternate,
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
                                 color: FlutterFlowTheme.of(context).onBackground,
                                 size: 20,
                               ),
                               Text(
                                 'Cuenta del Propietario',
                                 style: FlutterFlowTheme.of(context)
                                     .titleMedium
                                     .copyWith(
                                       font: GoogleFonts.urbanist(
                                         fontWeight: FontWeight.bold,
                                       ),
                                       color: FlutterFlowTheme.of(context)
                                           .primaryText,
                                       letterSpacing: 0.0,
                                       fontWeight: FontWeight.bold,
                                       height: 1.4,
                                     ),
                               ),
                             ].divide(SizedBox(width: 8)),
                           ),
                           wrapWithModel(
                             model: _model.formFieldModel4,
                             updateCallback: () => safeSetState(() {}),
                             child: FormFieldWidget(
                               hint: 'Nombre y Apellidos',
                               icon: 'person_rounded',
                               label: 'Nombre Completo',
                               isPassword: true,
                             ),
                           ),
                           wrapWithModel(
                             model: _model.formFieldModel5,
                             updateCallback: () => safeSetState(() {}),
                             child: FormFieldWidget(
                               hint: 'usuario123',
                               icon: 'alternate_email_rounded',
                               label: 'Nombre de Usuario',
                               isPassword: true,
                             ),
                           ),
                           wrapWithModel(
                             model: _model.formFieldModel6,
                             updateCallback: () => safeSetState(() {}),
                             child: FormFieldWidget(
                               hint: 'Mínimo 8 caracteres',
                               icon: 'lock_rounded',
                               label: 'Contraseña',
                               isPassword: true,
                             ),
                           ),
                           wrapWithModel(
                             model: _model.formFieldModel7,
                             updateCallback: () => safeSetState(() {}),
                             child: FormFieldWidget(
                               hint: 'Repite tu contraseña',
                               icon: 'lock_clock_rounded',
                               label: 'Confirmar Contraseña',
                               isPassword: true,
                             ),
                           ),
                         ].divide(SizedBox(height: 16)),
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
                       Container(
                         child: Padding(
                           padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                           child: Container(
                             child: InkWell(
                               splashColor: Colors.transparent,
                               focusColor: Colors.transparent,
                               hoverColor: Colors.transparent,
                               highlightColor: Colors.transparent,
                               onTap: () async {
                                 context.goNamed(PanelPrincipalWidget.routeName);
                               },
                               child: wrapWithModel(
                                 model: _model.buttonModel1,
                                 updateCallback: () => safeSetState(() {}),
                                 child: ButtonWidget(
                                   icon: Icon(
                                     Icons.arrow_forward_rounded,
                                     color:
                                         FlutterFlowTheme.of(context).primaryText,
                                     size: 24,
                                   ),
                                   iconPresent: true,
                                   iconEndPresent: false,
                                   content: 'Finalizar Registro',
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
                       Padding(
                         padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                         child: Row(
                           mainAxisSize: MainAxisSize.max,
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                               '¿Ya tienes un negocio?',
                               style:
                                   FlutterFlowTheme.of(context).bodySmall.copyWith(
                                         font: GoogleFonts.poppins(
                                           fontWeight: FlutterFlowTheme.of(context)
                                               .bodySmall
                                               .fontWeight,
                                         ),
                                         color: FlutterFlowTheme.of(context)
                                             .secondaryText,
                                         letterSpacing: 0.0,
                                         fontWeight: FlutterFlowTheme.of(context)
                                             .bodySmall
                                             .fontWeight,
                                         height: 1.4,
                                       ),
                             ),
                             InkWell(
                               splashColor: Colors.transparent,
                               focusColor: Colors.transparent,
                               hoverColor: Colors.transparent,
                               highlightColor: Colors.transparent,
                               onTap: () async {
                                 context.goNamed(InicioDeSesiNWidget.routeName);
                               },
                               child: wrapWithModel(
                                 model: _model.buttonModel2,
                                 updateCallback: () => safeSetState(() {}),
                                 child: ButtonWidget(
                                   iconPresent: false,
                                   iconEndPresent: false,
                                   content: 'Iniciar Sesión',
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
                       ),
                     ].divide(SizedBox(height: 24)),
                   ),
                 ),
               ],
             ),
           ),
         ),
       );
     }
  }
}
