import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/client_card/client_card_widget.dart';
import 'package:multi_p_o_s/components/credit_stat/credit_stat_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'clientes_y_cr_ditos_widget.dart' show ClientesYCrDitosWidget;
import 'package:flutter/material.dart';

class ClientesYCrDitosModel extends FlutterFlowModel<ClientesYCrDitosWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for CreditStat.
  late CreditStatModel creditStatModel1;
  // Model for CreditStat.
  late CreditStatModel creditStatModel2;
  // Model for ClientCard.
  late ClientCardModel clientCardModel1;
  // Model for ClientCard.
  late ClientCardModel clientCardModel2;
  // Model for ClientCard.
  late ClientCardModel clientCardModel3;
  // Model for ClientCard.
  late ClientCardModel clientCardModel4;
  // Model for ClientCard.
  late ClientCardModel clientCardModel5;
  // Model for Button.
  late ButtonModel buttonModel;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    creditStatModel1 = createModel(context, () => CreditStatModel());
    creditStatModel2 = createModel(context, () => CreditStatModel());
    clientCardModel1 = createModel(context, () => ClientCardModel());
    clientCardModel2 = createModel(context, () => ClientCardModel());
    clientCardModel3 = createModel(context, () => ClientCardModel());
    clientCardModel4 = createModel(context, () => ClientCardModel());
    clientCardModel5 = createModel(context, () => ClientCardModel());
    buttonModel = createModel(context, () => ButtonModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    creditStatModel1.dispose();
    creditStatModel2.dispose();
    clientCardModel1.dispose();
    clientCardModel2.dispose();
    clientCardModel3.dispose();
    clientCardModel4.dispose();
    clientCardModel5.dispose();
    buttonModel.dispose();
    bottomNavModel.dispose();
  }
}
