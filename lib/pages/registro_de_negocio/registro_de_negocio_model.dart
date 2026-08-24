import 'package:multi_p_o_s/components/business_type_card/business_type_card_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/checkbox/checkbox_widget.dart';
import 'package:multi_p_o_s/components/form_field/form_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:multi_p_o_s/index.dart';
import 'registro_de_negocio_widget.dart' show RegistroDeNegocioWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegistroDeNegocioModel extends FlutterFlowModel<RegistroDeNegocioWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for FormField.
  late FormFieldModel formFieldModel1;
  // Model for BusinessTypeCard.
  late BusinessTypeCardModel businessTypeCardModel1;
  // Model for BusinessTypeCard.
  late BusinessTypeCardModel businessTypeCardModel2;
  // Model for BusinessTypeCard.
  late BusinessTypeCardModel businessTypeCardModel3;
  // Model for BusinessTypeCard.
  late BusinessTypeCardModel businessTypeCardModel4;
  // Model for BusinessTypeCard.
  late BusinessTypeCardModel businessTypeCardModel5;
  // Model for FormField.
  late FormFieldModel formFieldModel2;
  // Model for FormField.
  late FormFieldModel formFieldModel3;
  // Model for FormField.
  late FormFieldModel formFieldModel4;
  // Model for FormField.
  late FormFieldModel formFieldModel5;
  // Model for FormField.
  late FormFieldModel formFieldModel6;
  // Model for FormField.
  late FormFieldModel formFieldModel7;
  // Model for Checkbox.
  late CheckboxModel checkboxModel;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    formFieldModel1 = createModel(context, () => FormFieldModel());
    businessTypeCardModel1 =
        createModel(context, () => BusinessTypeCardModel());
    businessTypeCardModel2 =
        createModel(context, () => BusinessTypeCardModel());
    businessTypeCardModel3 =
        createModel(context, () => BusinessTypeCardModel());
    businessTypeCardModel4 =
        createModel(context, () => BusinessTypeCardModel());
    businessTypeCardModel5 =
        createModel(context, () => BusinessTypeCardModel());
    formFieldModel2 = createModel(context, () => FormFieldModel());
    formFieldModel3 = createModel(context, () => FormFieldModel());
    formFieldModel4 = createModel(context, () => FormFieldModel());
    formFieldModel5 = createModel(context, () => FormFieldModel());
    formFieldModel6 = createModel(context, () => FormFieldModel());
    formFieldModel7 = createModel(context, () => FormFieldModel());
    checkboxModel = createModel(context, () => CheckboxModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    formFieldModel1.dispose();
    businessTypeCardModel1.dispose();
    businessTypeCardModel2.dispose();
    businessTypeCardModel3.dispose();
    businessTypeCardModel4.dispose();
    businessTypeCardModel5.dispose();
    formFieldModel2.dispose();
    formFieldModel3.dispose();
    formFieldModel4.dispose();
    formFieldModel5.dispose();
    formFieldModel6.dispose();
    formFieldModel7.dispose();
    checkboxModel.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
