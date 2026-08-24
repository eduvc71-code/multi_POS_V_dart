import 'package:multi_p_o_s/components/history_stat/history_stat_widget.dart';
import 'package:multi_p_o_s/components/sale_row/sale_row_widget.dart';
import 'package:multi_p_o_s/components/text_field/text_field_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:multi_p_o_s/index.dart';
import 'historial_de_ventas_widget.dart' show HistorialDeVentasWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HistorialDeVentasModel extends FlutterFlowModel<HistorialDeVentasWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for HistoryStat.
  late HistoryStatModel historyStatModel1;
  // Model for HistoryStat.
  late HistoryStatModel historyStatModel2;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for SaleRow.
  late SaleRowModel saleRowModel1;
  // Model for SaleRow.
  late SaleRowModel saleRowModel2;
  // Model for SaleRow.
  late SaleRowModel saleRowModel3;
  // Model for SaleRow.
  late SaleRowModel saleRowModel4;
  // Model for SaleRow.
  late SaleRowModel saleRowModel5;
  // Model for SaleRow.
  late SaleRowModel saleRowModel6;
  // Model for SaleRow.
  late SaleRowModel saleRowModel7;

  @override
  void initState(BuildContext context) {
    historyStatModel1 = createModel(context, () => HistoryStatModel());
    historyStatModel2 = createModel(context, () => HistoryStatModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    saleRowModel1 = createModel(context, () => SaleRowModel());
    saleRowModel2 = createModel(context, () => SaleRowModel());
    saleRowModel3 = createModel(context, () => SaleRowModel());
    saleRowModel4 = createModel(context, () => SaleRowModel());
    saleRowModel5 = createModel(context, () => SaleRowModel());
    saleRowModel6 = createModel(context, () => SaleRowModel());
    saleRowModel7 = createModel(context, () => SaleRowModel());
  }

  @override
  void dispose() {
    historyStatModel1.dispose();
    historyStatModel2.dispose();
    textFieldModel.dispose();
    saleRowModel1.dispose();
    saleRowModel2.dispose();
    saleRowModel3.dispose();
    saleRowModel4.dispose();
    saleRowModel5.dispose();
    saleRowModel6.dispose();
    saleRowModel7.dispose();
  }
}
