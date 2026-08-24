import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/cash_stat/cash_stat_widget.dart';
import 'package:multi_p_o_s/components/movement_item/movement_item_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'gesti_n_de_caja_widget.dart' show GestiNDeCajaWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GestiNDeCajaModel extends FlutterFlowModel<GestiNDeCajaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CashStat.
  late CashStatModel cashStatModel1;
  // Model for CashStat.
  late CashStatModel cashStatModel2;
  // Model for CashStat.
  late CashStatModel cashStatModel3;
  // Model for CashStat.
  late CashStatModel cashStatModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for MovementItem.
  late MovementItemModel movementItemModel1;
  // Model for MovementItem.
  late MovementItemModel movementItemModel2;
  // Model for MovementItem.
  late MovementItemModel movementItemModel3;
  // Model for MovementItem.
  late MovementItemModel movementItemModel4;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel3;

  @override
  void initState(BuildContext context) {
    cashStatModel1 = createModel(context, () => CashStatModel());
    cashStatModel2 = createModel(context, () => CashStatModel());
    cashStatModel3 = createModel(context, () => CashStatModel());
    cashStatModel4 = createModel(context, () => CashStatModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    movementItemModel1 = createModel(context, () => MovementItemModel());
    movementItemModel2 = createModel(context, () => MovementItemModel());
    movementItemModel3 = createModel(context, () => MovementItemModel());
    movementItemModel4 = createModel(context, () => MovementItemModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel3 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    cashStatModel1.dispose();
    cashStatModel2.dispose();
    cashStatModel3.dispose();
    cashStatModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
    movementItemModel1.dispose();
    movementItemModel2.dispose();
    movementItemModel3.dispose();
    movementItemModel4.dispose();
    textFieldModel.dispose();
    buttonModel3.dispose();
  }
}
